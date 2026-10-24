<?php
if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit('Not found.');
}

require dirname(__DIR__) . DIRECTORY_SEPARATOR . 'db.php';

$pdo->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
$lockName = 'defimap_curated_dataset_import';
$lock = $pdo->prepare('SELECT GET_LOCK(?, 10)');
$lock->execute([$lockName]);
if ((int)$lock->fetchColumn() !== 1) {
    throw new RuntimeException('Could not obtain the dataset import lock.');
}

function readDataset(string $filename, array $expectedHeaders): array
{
    $path = __DIR__ . DIRECTORY_SEPARATOR . $filename;
    $handle = fopen($path, 'rb');
    if ($handle === false) {
        throw new RuntimeException('Unable to open dataset: ' . $filename);
    }

    try {
        $headers = fgetcsv($handle, 0, ',', '"', '');
        if (isset($headers[0])) {
            $headers[0] = preg_replace('/^\xEF\xBB\xBF/', '', $headers[0]);
        }
        if ($headers !== $expectedHeaders) {
            throw new RuntimeException('Unexpected CSV headers in ' . $filename);
        }

        $rows = [];
        $line = 1;
        while (($values = fgetcsv($handle, 0, ',', '"', '')) !== false) {
            $line++;
            if (count($values) !== count($headers)) {
                throw new RuntimeException($filename . ' line ' . $line . ' has an invalid field count.');
            }
            foreach ($values as $value) {
                if (preg_match('//u', $value) !== 1) {
                    throw new RuntimeException($filename . ' line ' . $line . ' is not valid UTF-8.');
                }
            }
            $row = array_combine($headers, $values);
            foreach ($row as $column => $value) {
                $optional = in_array($column, ['description', 'pathway_id', 'source_url'], true);
                if (!$optional && trim((string)$value) === '') {
                    throw new RuntimeException($filename . ' line ' . $line . ' is missing ' . $column . '.');
                }
            }
            foreach ($row as $column => $value) {
                if ($column === 'source_url' && trim($value) !== '') {
                    $parts = parse_url($value);
                    if (filter_var($value, FILTER_VALIDATE_URL) === false
                        || !isset($parts['scheme'])
                        || !in_array(strtolower($parts['scheme']), ['http', 'https'], true)) {
                        throw new RuntimeException($filename . ' line ' . $line . ' has an invalid source URL.');
                    }
                }
            }
            $rows[] = $row;
        }

        return $rows;
    } finally {
        fclose($handle);
    }
}

function idValue(string $value, string $field): int
{
    $id = filter_var($value, FILTER_VALIDATE_INT);
    if ($id === false || $id < 1) {
        throw new RuntimeException('Invalid positive integer in ' . $field . '.');
    }
    return $id;
}

function insertIfNewOrVerify(
    PDO $pdo,
    string $selectSql,
    array $selectValues,
    string $insertSql,
    array $insertValues,
    array $expected
): bool {
    $select = $pdo->prepare($selectSql);
    $select->execute($selectValues);
    $existing = $select->fetch(PDO::FETCH_ASSOC);
    if ($existing !== false) {
        foreach ($expected as $column => $value) {
            $existingValue = (string)($existing[$column] ?? '');
            $incomingValue = (string)($value ?? '');
            $same = in_array($column, [
                'deficiency_name', 'symptom_name', 'gene_symbol', 'gene_name',
                'protein_name', 'uniprot_accession', 'pathway_name',
                'dataset_name', 'organization',
            ], true)
                ? strcasecmp(trim($existingValue), trim($incomingValue)) === 0
                : $existingValue === $incomingValue;
            if (!$same) {
                throw new RuntimeException('Existing record conflicts on ' . $column . '; no data was changed.');
            }
        }
        return false;
    }

    $insert = $pdo->prepare($insertSql);
    $insert->execute($insertValues);
    return true;
}

function ensureParent(PDO $pdo, string $table, string $idColumn, int $id): void
{
    $query = $pdo->prepare('SELECT 1 FROM ' . $table . ' WHERE ' . $idColumn . ' = ?');
    $query->execute([$id]);
    if ($query->fetchColumn() === false) {
        throw new RuntimeException('Cannot import a relationship with missing ' . $table . ' ID ' . $id . '.');
    }
}

$counts = [];
$datasets = [
    'deficiency_master.csv' => ['deficiency_id', 'deficiency_name', 'description', 'related_nutrient', 'source_url'],
    'symptom_master.csv' => ['symptom_id', 'symptom_name', 'description', 'source_url'],
    'deficiency_symptoms.csv' => ['deficiency_id', 'symptom_id', 'weight', 'evidence_note', 'source_url'],
    'gene_associations.csv' => ['association_id', 'deficiency_id', 'gene_symbol', 'gene_id', 'gene_name', 'association_description', 'source_url'],
    'protein_associations.csv' => ['association_id', 'deficiency_id', 'protein_name', 'uniprot_accession', 'protein_function', 'association_description', 'source_url'],
    'pathway_associations.csv' => ['association_id', 'deficiency_id', 'pathway_name', 'pathway_id', 'pathway_description', 'source_url'],
    'dataset_sources.csv' => ['source_id', 'dataset_name', 'organization', 'source_url', 'record_identifier', 'version_or_release', 'access_date', 'license', 'verification_status'],
];

try {
    $rowsByFile = [];
    foreach ($datasets as $filename => $headers) {
        $rowsByFile[$filename] = readDataset($filename, $headers);
        $counts[$filename] = ['csv' => count($rowsByFile[$filename]), 'inserted' => 0, 'already_present' => 0];
    }

    $uniqueKeys = [
        'deficiency_master.csv' => static fn(array $row): string => $row['deficiency_id'],
        'symptom_master.csv' => static fn(array $row): string => $row['symptom_id'],
        'deficiency_symptoms.csv' => static fn(array $row): string => $row['deficiency_id'] . ':' . $row['symptom_id'],
        'gene_associations.csv' => static fn(array $row): string => $row['association_id'],
        'protein_associations.csv' => static fn(array $row): string => $row['association_id'],
        'pathway_associations.csv' => static fn(array $row): string => $row['association_id'],
        'dataset_sources.csv' => static fn(array $row): string => $row['source_id'],
    ];
    foreach ($uniqueKeys as $filename => $keyForRow) {
        $seen = [];
        foreach ($rowsByFile[$filename] as $row) {
            $key = $keyForRow($row);
            if (isset($seen[$key])) {
                throw new RuntimeException('Duplicate logical key in ' . $filename . ': ' . $key);
            }
            $seen[$key] = true;
        }
    }

    $pdo->beginTransaction();

    foreach ($rowsByFile['deficiency_master.csv'] as $row) {
        $id = idValue($row['deficiency_id'], 'deficiency_id');
        $inserted = insertIfNewOrVerify(
            $pdo,
            'SELECT deficiency_id, deficiency_name, description FROM deficiency_master WHERE deficiency_id = ? OR LOWER(deficiency_name) = LOWER(?) ORDER BY (deficiency_id = ?) DESC LIMIT 1',
            [$id, $row['deficiency_name'], $id],
            'INSERT INTO deficiency_master (deficiency_id, deficiency_name, description, cause) VALUES (?, ?, ?, ?)',
            [$id, $row['deficiency_name'], $row['description'], ''],
            ['deficiency_id' => $id, 'deficiency_name' => $row['deficiency_name'], 'description' => $row['description']]
        );
        $counts['deficiency_master.csv'][$inserted ? 'inserted' : 'already_present']++;

        $inserted = insertIfNewOrVerify(
            $pdo,
            'SELECT deficiency_id, related_nutrient, source_url FROM deficiency_metadata WHERE deficiency_id = ?',
            [$id],
            'INSERT INTO deficiency_metadata (deficiency_id, related_nutrient, source_url) VALUES (?, ?, ?)',
            [$id, $row['related_nutrient'], $row['source_url']],
            ['deficiency_id' => $id, 'related_nutrient' => $row['related_nutrient'], 'source_url' => $row['source_url']]
        );
    }

    foreach ($rowsByFile['symptom_master.csv'] as $row) {
        $id = idValue($row['symptom_id'], 'symptom_id');
        $inserted = insertIfNewOrVerify(
            $pdo,
            'SELECT symptom_id, symptom_name FROM symptom_master WHERE symptom_id = ? OR LOWER(symptom_name) = LOWER(?) ORDER BY (symptom_id = ?) DESC LIMIT 1',
            [$id, $row['symptom_name'], $id],
            'INSERT INTO symptom_master (symptom_id, symptom_name) VALUES (?, ?)',
            [$id, $row['symptom_name']],
            ['symptom_id' => $id, 'symptom_name' => $row['symptom_name']]
        );
        $counts['symptom_master.csv'][$inserted ? 'inserted' : 'already_present']++;

        insertIfNewOrVerify(
            $pdo,
            'SELECT symptom_id, description, source_url FROM symptom_metadata WHERE symptom_id = ?',
            [$id],
            'INSERT INTO symptom_metadata (symptom_id, description, source_url) VALUES (?, ?, ?)',
            [$id, $row['description'], $row['source_url']],
            ['symptom_id' => $id, 'description' => $row['description'], 'source_url' => $row['source_url']]
        );
    }

    foreach ($rowsByFile['deficiency_symptoms.csv'] as $row) {
        $deficiencyId = idValue($row['deficiency_id'], 'deficiency_id');
        $symptomId = idValue($row['symptom_id'], 'symptom_id');
        ensureParent($pdo, 'deficiency_master', 'deficiency_id', $deficiencyId);
        ensureParent($pdo, 'symptom_master', 'symptom_id', $symptomId);
        $weight = filter_var($row['weight'], FILTER_VALIDATE_INT);
        if ($weight === false || $weight < 0) {
            throw new RuntimeException('Invalid rule weight in deficiency_symptoms.csv.');
        }

        $inserted = insertIfNewOrVerify(
            $pdo,
            'SELECT deficiency_id, symptom_id, weight FROM deficiency_symptoms WHERE deficiency_id = ? AND symptom_id = ? LIMIT 1',
            [$deficiencyId, $symptomId],
            'INSERT INTO deficiency_symptoms (deficiency_id, symptom_id, weight) VALUES (?, ?, ?)',
            [$deficiencyId, $symptomId, $weight],
            ['deficiency_id' => $deficiencyId, 'symptom_id' => $symptomId, 'weight' => $weight]
        );
        $counts['deficiency_symptoms.csv'][$inserted ? 'inserted' : 'already_present']++;
        insertIfNewOrVerify(
            $pdo,
            'SELECT deficiency_id, symptom_id, evidence_note, source_url FROM deficiency_symptom_metadata WHERE deficiency_id = ? AND symptom_id = ?',
            [$deficiencyId, $symptomId],
            'INSERT INTO deficiency_symptom_metadata (deficiency_id, symptom_id, evidence_note, source_url) VALUES (?, ?, ?, ?)',
            [$deficiencyId, $symptomId, $row['evidence_note'], $row['source_url']],
            ['deficiency_id' => $deficiencyId, 'symptom_id' => $symptomId, 'evidence_note' => $row['evidence_note'], 'source_url' => $row['source_url']]
        );
    }

    foreach ($rowsByFile['gene_associations.csv'] as $row) {
        $id = idValue($row['association_id'], 'association_id');
        $deficiencyId = idValue($row['deficiency_id'], 'deficiency_id');
        $geneId = $row['gene_id'] === '' ? null : idValue($row['gene_id'], 'gene_id');
        ensureParent($pdo, 'deficiency_master', 'deficiency_id', $deficiencyId);
        $inserted = insertIfNewOrVerify(
            $pdo,
            'SELECT id, deficiency_id, gene_symbol, gene_name, ncbi_gene_id FROM gene_associations WHERE id = ? OR (deficiency_id = ? AND gene_symbol = ?) ORDER BY (id = ?) DESC LIMIT 1',
            [$id, $deficiencyId, $row['gene_symbol'], $id],
            'INSERT INTO gene_associations (id, deficiency_id, gene_symbol, gene_name, ncbi_gene_id) VALUES (?, ?, ?, ?, ?)',
            [$id, $deficiencyId, $row['gene_symbol'], $row['gene_name'], $geneId],
            ['id' => $id, 'deficiency_id' => $deficiencyId, 'gene_symbol' => $row['gene_symbol'], 'ncbi_gene_id' => $geneId]
        );
        $counts['gene_associations.csv'][$inserted ? 'inserted' : 'already_present']++;
        insertIfNewOrVerify(
            $pdo,
            'SELECT association_id, association_description, source_url FROM gene_association_metadata WHERE association_id = ?',
            [$id],
            'INSERT INTO gene_association_metadata (association_id, association_description, source_url) VALUES (?, ?, ?)',
            [$id, $row['association_description'], $row['source_url']],
            ['association_id' => $id, 'association_description' => $row['association_description'], 'source_url' => $row['source_url']]
        );
    }

    foreach ($rowsByFile['protein_associations.csv'] as $row) {
        $id = idValue($row['association_id'], 'association_id');
        $deficiencyId = idValue($row['deficiency_id'], 'deficiency_id');
        ensureParent($pdo, 'deficiency_master', 'deficiency_id', $deficiencyId);
        $inserted = insertIfNewOrVerify(
            $pdo,
            'SELECT id, deficiency_id, protein_name, uniprot_accession FROM protein_associations WHERE id = ? OR (deficiency_id = ? AND ((? <> \'\' AND uniprot_accession = ?) OR (? = \'\' AND protein_name = ?))) ORDER BY (id = ?) DESC LIMIT 1',
            [$id, $deficiencyId, $row['uniprot_accession'], $row['uniprot_accession'], $row['uniprot_accession'], $row['protein_name'], $id],
            'INSERT INTO protein_associations (id, deficiency_id, protein_name, uniprot_accession) VALUES (?, ?, ?, ?)',
            [$id, $deficiencyId, $row['protein_name'], $row['uniprot_accession']],
            ['id' => $id, 'deficiency_id' => $deficiencyId, 'uniprot_accession' => $row['uniprot_accession']]
        );
        $counts['protein_associations.csv'][$inserted ? 'inserted' : 'already_present']++;
        insertIfNewOrVerify(
            $pdo,
            'SELECT association_id, protein_function, association_description, source_url FROM protein_association_metadata WHERE association_id = ?',
            [$id],
            'INSERT INTO protein_association_metadata (association_id, protein_function, association_description, source_url) VALUES (?, ?, ?, ?)',
            [$id, $row['protein_function'], $row['association_description'], $row['source_url']],
            ['association_id' => $id, 'protein_function' => $row['protein_function'], 'association_description' => $row['association_description'], 'source_url' => $row['source_url']]
        );
    }

    foreach ($rowsByFile['pathway_associations.csv'] as $row) {
        $id = idValue($row['association_id'], 'association_id');
        $deficiencyId = idValue($row['deficiency_id'], 'deficiency_id');
        ensureParent($pdo, 'deficiency_master', 'deficiency_id', $deficiencyId);
        $inserted = insertIfNewOrVerify(
            $pdo,
            'SELECT id, deficiency_id, pathway_name FROM pathway_associations WHERE id = ? OR (deficiency_id = ? AND LOWER(TRIM(pathway_name)) = LOWER(TRIM(?))) ORDER BY (id = ?) DESC LIMIT 1',
            [$id, $deficiencyId, $row['pathway_name'], $id],
            'INSERT INTO pathway_associations (id, deficiency_id, pathway_name) VALUES (?, ?, ?)',
            [$id, $deficiencyId, $row['pathway_name']],
            ['id' => $id, 'deficiency_id' => $deficiencyId, 'pathway_name' => $row['pathway_name']]
        );
        $counts['pathway_associations.csv'][$inserted ? 'inserted' : 'already_present']++;
        insertIfNewOrVerify(
            $pdo,
            'SELECT association_id, pathway_id, pathway_description, source_url FROM pathway_association_metadata WHERE association_id = ?',
            [$id],
            'INSERT INTO pathway_association_metadata (association_id, pathway_id, pathway_description, source_url) VALUES (?, ?, ?, ?)',
            [$id, $row['pathway_id'], $row['pathway_description'], $row['source_url']],
            ['association_id' => $id, 'pathway_id' => $row['pathway_id'], 'pathway_description' => $row['pathway_description'], 'source_url' => $row['source_url']]
        );
    }

    foreach ($rowsByFile['dataset_sources.csv'] as $row) {
        $id = idValue($row['source_id'], 'source_id');
        $inserted = insertIfNewOrVerify(
            $pdo,
            'SELECT source_id, dataset_name, organization, source_url, record_identifier, version_or_release, access_date, license, verification_status FROM dataset_sources WHERE source_id = ? OR (dataset_name = ? AND organization = ? AND source_url = ? AND record_identifier = ?) ORDER BY (source_id = ?) DESC LIMIT 1',
            [$id, $row['dataset_name'], $row['organization'], $row['source_url'], $row['record_identifier'], $id],
            'INSERT INTO dataset_sources (source_id, dataset_name, organization, source_url, record_identifier, version_or_release, access_date, license, verification_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
            [$id, $row['dataset_name'], $row['organization'], $row['source_url'], $row['record_identifier'], $row['version_or_release'], $row['access_date'], $row['license'], $row['verification_status']],
            ['source_id' => $id, 'dataset_name' => $row['dataset_name'], 'organization' => $row['organization'], 'source_url' => $row['source_url'], 'record_identifier' => $row['record_identifier'], 'version_or_release' => $row['version_or_release'], 'access_date' => $row['access_date'], 'license' => $row['license'], 'verification_status' => $row['verification_status']]
        );
        $counts['dataset_sources.csv'][$inserted ? 'inserted' : 'already_present']++;
    }

    $pdo->commit();
} catch (Throwable $error) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    throw $error;
} finally {
    $release = $pdo->prepare('SELECT RELEASE_LOCK(?)');
    $release->execute([$lockName]);
}

foreach ($counts as $filename => $count) {
    fwrite(STDOUT, sprintf(
        "%s: %d CSV rows; %d inserted; %d already present.\n",
        $filename,
        $count['csv'],
        $count['inserted'],
        $count['already_present']
    ));
}
fwrite(STDOUT, "Import completed. Existing data was preserved; no food recommendation rows were imported or changed.\n");
