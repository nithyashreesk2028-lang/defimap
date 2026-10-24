<?php
if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit('Not found.');
}

require dirname(__DIR__) . DIRECTORY_SEPARATOR . 'db.php';

$specifications = [
    'food_nutrient_data.csv' => [
        'table' => 'food_nutrient_data',
        'headers' => [
            'food_record_id', 'fdc_id', 'food_name', 'nutrient_name',
            'nutrient_amount', 'nutrient_unit', 'serving_basis',
            'source_url', 'verification_status',
        ],
        'unique' => static fn(array $row): string => $row['fdc_id'] . ':' . $row['nutrient_name'],
    ],
    'compound_data.csv' => [
        'table' => 'compound_data',
        'headers' => [
            'compound_id', 'pubchem_cid', 'compound_name', 'molecular_formula',
            'molecular_weight', 'related_nutrient', 'source_url', 'verification_status',
        ],
        'unique' => static fn(array $row): string => $row['pubchem_cid'],
    ],
];

$failed = false;
foreach ($specifications as $filename => $specification) {
    $path = __DIR__ . DIRECTORY_SEPARATOR . $filename;
    $handle = fopen($path, 'rb');
    if ($handle === false) {
        fwrite(STDERR, "FAIL: cannot open $filename.\n");
        $failed = true;
        continue;
    }

    $headers = fgetcsv($handle, 0, ',', '"', '');
    if (isset($headers[0])) {
        $headers[0] = preg_replace('/^\xEF\xBB\xBF/', '', $headers[0]);
    }
    if ($headers !== $specification['headers']) {
        fwrite(STDERR, "FAIL: unexpected headers in $filename.\n");
        fclose($handle);
        $failed = true;
        continue;
    }

    $rows = [];
    $seenIds = [];
    $seenUnique = [];
    $statusCounts = [
        'verified' => 0,
        'partially verified' => 0,
        'pending verification' => 0,
        'rejected' => 0,
    ];
    $line = 1;
    while (($values = fgetcsv($handle, 0, ',', '"', '')) !== false) {
        $line++;
        if (count($values) !== count($headers)) {
            fwrite(STDERR, "FAIL: $filename line $line has an invalid field count.\n");
            $failed = true;
            continue;
        }
        $row = array_combine($headers, $values);
        $idColumn = $filename === 'food_nutrient_data.csv' ? 'food_record_id' : 'compound_id';
        $id = (string)$row[$idColumn];
        $unique = $specification['unique']($row);
        if (isset($seenIds[$id]) || isset($seenUnique[$unique])) {
            fwrite(STDERR, "FAIL: duplicate key in $filename line $line.\n");
            $failed = true;
        }
        $seenIds[$id] = true;
        $seenUnique[$unique] = true;
        if (!isset($statusCounts[$row['verification_status']])) {
            fwrite(STDERR, "FAIL: unsupported verification status in $filename line $line.\n");
            $failed = true;
        } else {
            $statusCounts[$row['verification_status']]++;
        }
        if (filter_var($row['source_url'], FILTER_VALIDATE_URL) === false) {
            fwrite(STDERR, "FAIL: invalid source URL in $filename line $line.\n");
            $failed = true;
        }
        $rows[] = $row;
    }
    fclose($handle);

    $databaseCount = (int)$pdo->query(
        'SELECT COUNT(*) FROM ' . $specification['table']
    )->fetchColumn();
    if ($databaseCount !== count($rows)) {
        fwrite(STDERR, "FAIL: $filename has " . count($rows) . " CSV rows but $databaseCount database rows.\n");
        $failed = true;
    }
    fwrite(STDOUT, sprintf(
        "%s: %d CSV rows; %d database rows; verified=%d, partially verified=%d, pending=%d, rejected=%d.\n",
        $filename,
        count($rows),
        $databaseCount,
        $statusCounts['verified'],
        $statusCounts['partially verified'],
        $statusCounts['pending verification'],
        $statusCounts['rejected']
    ));
}

$preservedCounts = [
    'deficiency_master' => 20,
    'symptom_master' => 20,
    'deficiency_symptoms' => 48,
    'food_recommendations' => 85,
    'gene_associations' => 5,
    'protein_associations' => 5,
    'pathway_associations' => 4,
];
foreach ($preservedCounts as $table => $expected) {
    $actual = (int)$pdo->query('SELECT COUNT(*) FROM ' . $table)->fetchColumn();
    fwrite(STDOUT, "$table: $actual rows (baseline $expected).\n");
    if ($actual !== $expected) {
        fwrite(STDERR, "FAIL: unexpected row count in $table.\n");
        $failed = true;
    }
}

$orphanCount = (int)$pdo->query(
    'SELECT COUNT(*) FROM deficiency_symptoms ds
     LEFT JOIN deficiency_master d ON d.deficiency_id = ds.deficiency_id
     LEFT JOIN symptom_master s ON s.symptom_id = ds.symptom_id
     WHERE d.deficiency_id IS NULL OR s.symptom_id IS NULL'
)->fetchColumn();
fwrite(STDOUT, "deficiency_symptoms orphan relationships: $orphanCount.\n");
if ($orphanCount !== 0) {
    $failed = true;
}

if ($failed) {
    fwrite(STDERR, "FAIL: scientific dataset validation found issues.\n");
    exit(1);
}

fwrite(STDOUT, "PASS: CSV structure, identifiers, source URLs, imported counts, and existing dataset counts validated.\n");
