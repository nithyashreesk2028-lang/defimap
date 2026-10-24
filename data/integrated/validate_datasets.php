<?php
if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit('Not found.');
}

require __DIR__ . '/../../db.php';

$specifications = [
    'deficiency_master.csv' => ['deficiency_id', 'deficiency_name', 'description', 'related_nutrient', 'source_url'],
    'symptom_master.csv' => ['symptom_id', 'symptom_name', 'description', 'source_url'],
    'deficiency_symptoms.csv' => ['deficiency_id', 'symptom_id', 'weight', 'evidence_note', 'source_url'],
    'food_recommendations.csv' => ['deficiency_id', 'food_name', 'nutrient_name', 'benefit', 'caution', 'source_url'],
    'gene_associations.csv' => ['association_id', 'deficiency_id', 'gene_symbol', 'gene_id', 'gene_name', 'association_description', 'source_url'],
    'protein_associations.csv' => ['association_id', 'deficiency_id', 'protein_name', 'uniprot_accession', 'protein_function', 'association_description', 'source_url'],
    'pathway_associations.csv' => ['association_id', 'deficiency_id', 'pathway_name', 'pathway_id', 'pathway_description', 'source_url'],
    'dataset_sources.csv' => ['source_id', 'dataset_name', 'organization', 'source_url', 'record_identifier', 'version_or_release', 'access_date', 'license', 'verification_status'],
];
$rowsByFile = [];
$failures = [];
$blankSourceCount = [];

foreach ($specifications as $filename => $expectedHeaders) {
    $path = __DIR__ . DIRECTORY_SEPARATOR . $filename;
    $handle = fopen($path, 'rb');
    if ($handle === false) {
        $failures[] = "Cannot open $filename";
        continue;
    }

    $headers = fgetcsv($handle, 0, ',', '"', '');
    if (isset($headers[0])) {
        $headers[0] = preg_replace('/^\xEF\xBB\xBF/', '', $headers[0]);
    }
    if ($headers !== $expectedHeaders) {
        $failures[] = "Unexpected headers in $filename";
        fclose($handle);
        continue;
    }

    $rows = [];
    $rowNumber = 1;
    while (($values = fgetcsv($handle, 0, ',', '"', '')) !== false) {
        $rowNumber++;
        if (count($values) !== count($headers)) {
            $failures[] = "$filename row $rowNumber has " . count($values) . ' fields; expected ' . count($headers);
            continue;
        }
        $rows[] = array_combine($headers, $values);
    }
    fclose($handle);
    $rowsByFile[$filename] = $rows;
    $blankSourceCount[$filename] = count(array_filter(
        $rows,
        static fn(array $row): bool => trim((string)($row['source_url'] ?? '')) === ''
    ));
    fwrite(STDOUT, "$filename: " . count($rows) . " rows; headers and CSV field counts valid.\n");
}

if (count($rowsByFile) !== count($specifications)) {
    fwrite(STDERR, implode(PHP_EOL, $failures) . PHP_EOL);
    exit(1);
}

$uniqueChecks = [
    ['deficiency_master.csv', static fn(array $row): string => $row['deficiency_id']],
    ['symptom_master.csv', static fn(array $row): string => $row['symptom_id']],
    ['deficiency_symptoms.csv', static fn(array $row): string => $row['deficiency_id'] . ':' . $row['symptom_id']],
    ['food_recommendations.csv', static fn(array $row): string => $row['deficiency_id'] . ':' . strtolower(trim($row['food_name']))],
    ['gene_associations.csv', static fn(array $row): string => $row['association_id']],
    ['protein_associations.csv', static fn(array $row): string => $row['association_id']],
    ['pathway_associations.csv', static fn(array $row): string => $row['association_id']],
    ['dataset_sources.csv', static fn(array $row): string => $row['source_id']],
];
foreach ($uniqueChecks as [$filename, $keyForRow]) {
    $seen = [];
    foreach ($rowsByFile[$filename] as $row) {
        $key = $keyForRow($row);
        if (isset($seen[$key])) {
            $failures[] = "Duplicate key '$key' in $filename";
        }
        $seen[$key] = true;
    }
}

$deficiencyIds = array_fill_keys(array_column($rowsByFile['deficiency_master.csv'], 'deficiency_id'), true);
$symptomIds = array_fill_keys(array_column($rowsByFile['symptom_master.csv'], 'symptom_id'), true);
foreach (['deficiency_symptoms.csv', 'food_recommendations.csv', 'gene_associations.csv', 'protein_associations.csv', 'pathway_associations.csv'] as $filename) {
    foreach ($rowsByFile[$filename] as $row) {
        if (!isset($deficiencyIds[$row['deficiency_id']])) {
            $failures[] = "Invalid deficiency_id {$row['deficiency_id']} in $filename";
        }
    }
}
foreach ($rowsByFile['deficiency_symptoms.csv'] as $row) {
    if (!isset($symptomIds[$row['symptom_id']])) {
        $failures[] = "Invalid symptom_id {$row['symptom_id']} in deficiency_symptoms.csv";
    }
}

foreach ($rowsByFile as $filename => $rows) {
    foreach ($rows as $index => $row) {
        foreach ($row as $column => $value) {
            if (in_array($column, ['pathway_id'], true)) {
                continue;
            }
            if (trim((string)$value) === ''
                && !($column === 'source_url' && $filename === 'dataset_sources.csv'
                    && $row['organization'] === 'DefiMap local project database')) {
                $failures[] = "Missing required value for $column in $filename row " . ($index + 2);
            }
        }
        $url = trim((string)($row['source_url'] ?? ''));
        if ($url !== '' && filter_var($url, FILTER_VALIDATE_URL) === false) {
            $failures[] = "Invalid source_url in $filename row " . ($index + 2);
        }
    }
}

$expectedCounts = [
    'deficiency_master.csv' => (int)$pdo->query('SELECT COUNT(*) FROM deficiency_master')->fetchColumn(),
    'symptom_master.csv' => (int)$pdo->query('SELECT COUNT(*) FROM symptom_master')->fetchColumn(),
    'deficiency_symptoms.csv' => (int)$pdo->query('SELECT COUNT(*) FROM deficiency_symptoms')->fetchColumn(),
    'food_recommendations.csv' => (int)$pdo->query('SELECT COUNT(*) FROM food_recommendations')->fetchColumn(),
    'gene_associations.csv' => (int)$pdo->query('SELECT COUNT(*) FROM gene_associations')->fetchColumn(),
    'protein_associations.csv' => (int)$pdo->query('SELECT COUNT(*) FROM protein_associations')->fetchColumn(),
    'pathway_associations.csv' => (int)$pdo->query('SELECT COUNT(*) FROM pathway_associations')->fetchColumn(),
];
foreach ($expectedCounts as $filename => $expectedCount) {
    if (count($rowsByFile[$filename]) !== $expectedCount) {
        $failures[] = "$filename has " . count($rowsByFile[$filename]) . " rows but live database has $expectedCount";
    }
}

if ($failures) {
    fwrite(STDERR, implode(PHP_EOL, $failures) . PHP_EOL);
    exit(1);
}

fwrite(STDOUT, "PASS: unique keys, foreign-key references, live row counts, and source URL presence validated.\n");
fwrite(STDOUT, 'Blank source URLs allowed for local-only provenance rows: '
    . ($blankSourceCount['dataset_sources.csv'] ?? 0) . PHP_EOL);
fwrite(STDOUT, "Scientific verification limits are documented in validation_report.md.\n");
