<?php
if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit('Not found.');
}

require dirname(__DIR__) . DIRECTORY_SEPARATOR . 'db.php';

$pdo->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
$lockName = 'defimap_scientific_dataset_import';
$lock = $pdo->prepare('SELECT GET_LOCK(?, 10)');
$lock->execute([$lockName]);
if ((int)$lock->fetchColumn() !== 1) {
    throw new RuntimeException('Could not obtain the scientific dataset import lock.');
}

function readScientificCsv(string $filename, array $headers): array
{
    $path = __DIR__ . DIRECTORY_SEPARATOR . $filename;
    $handle = fopen($path, 'rb');
    if ($handle === false) {
        throw new RuntimeException('Unable to open ' . $filename . '.');
    }

    try {
        $actualHeaders = fgetcsv($handle, 0, ',', '"', '');
        if (isset($actualHeaders[0])) {
            $actualHeaders[0] = preg_replace('/^\xEF\xBB\xBF/', '', $actualHeaders[0]);
        }
        if ($actualHeaders !== $headers) {
            throw new RuntimeException('Unexpected headers in ' . $filename . '.');
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
            $rows[] = ['line' => $line, 'data' => array_combine($headers, $values)];
        }

        return $rows;
    } finally {
        fclose($handle);
    }
}

function validPositiveInteger(string $value): bool
{
    $number = filter_var($value, FILTER_VALIDATE_INT);
    return $number !== false && $number > 0;
}

function validateScientificRow(array $row, string $kind): ?string
{
    foreach ($row as $field => $value) {
        if (trim((string)$value) === '') {
            return 'missing required value for ' . $field;
        }
    }
    if (!in_array($row['verification_status'], [
        'verified', 'partially verified', 'pending verification', 'rejected',
    ], true)) {
        return 'unsupported verification_status';
    }
    if (filter_var($row['source_url'], FILTER_VALIDATE_URL) === false
        || !in_array(strtolower((string)parse_url($row['source_url'], PHP_URL_SCHEME)), ['http', 'https'], true)) {
        return 'invalid source_url';
    }

    if ($kind === 'food') {
        if (!validPositiveInteger($row['food_record_id']) || !validPositiveInteger($row['fdc_id'])) {
            return 'food_record_id and fdc_id must be positive integers';
        }
        if (!is_numeric($row['nutrient_amount']) || (float)$row['nutrient_amount'] < 0) {
            return 'nutrient_amount must be a nonnegative number';
        }
        if (!preg_match('/^[A-Za-z]+$/', $row['nutrient_unit'])) {
            return 'nutrient_unit must be an alphabetic unit';
        }
    } else {
        if (!validPositiveInteger($row['compound_id']) || !validPositiveInteger($row['pubchem_cid'])) {
            return 'compound_id and pubchem_cid must be positive integers';
        }
        if (!is_numeric($row['molecular_weight']) || (float)$row['molecular_weight'] <= 0) {
            return 'molecular_weight must be positive';
        }
    }

    return null;
}

function sameScientificRecord(array $existing, array $incoming): bool
{
    foreach ($incoming as $column => $value) {
        if (in_array($column, ['nutrient_amount', 'molecular_weight'], true)) {
            if (abs((float)$existing[$column] - (float)$value) > 0.00000001) {
                return false;
            }
        } elseif ((string)$existing[$column] !== (string)$value) {
            return false;
        }
    }

    return true;
}

$specifications = [
    'food_nutrient_data.csv' => [
        'kind' => 'food',
        'table' => 'food_nutrient_data',
        'headers' => [
            'food_record_id', 'fdc_id', 'food_name', 'nutrient_name',
            'nutrient_amount', 'nutrient_unit', 'serving_basis',
            'source_url', 'verification_status',
        ],
        'primary_key' => 'food_record_id',
        'natural_key' => ['fdc_id', 'nutrient_name'],
    ],
    'compound_data.csv' => [
        'kind' => 'compound',
        'table' => 'compound_data',
        'headers' => [
            'compound_id', 'pubchem_cid', 'compound_name', 'molecular_formula',
            'molecular_weight', 'related_nutrient', 'source_url', 'verification_status',
        ],
        'primary_key' => 'compound_id',
        'natural_key' => ['pubchem_cid'],
    ],
];

$counts = [];
$importFailure = null;
try {
    $pdo->beginTransaction();

    foreach ($specifications as $filename => $specification) {
        $rows = readScientificCsv($filename, $specification['headers']);
        $columns = $specification['headers'];
        $columnSql = implode(', ', $columns);
        $placeholders = implode(', ', array_fill(0, count($columns), '?'));
        $insert = $pdo->prepare(
            'INSERT INTO ' . $specification['table'] . ' (' . $columnSql . ') VALUES (' . $placeholders . ')'
        );
        $naturalWhere = implode(' AND ', array_map(
            static fn(string $key): string => $key . ' = ?',
            $specification['natural_key']
        ));
        $keyWhere = $specification['primary_key'] . ' = ? OR (' . $naturalWhere . ')';
        $select = $pdo->prepare(
            'SELECT ' . $columnSql . ' FROM ' . $specification['table'] . ' WHERE ' . $keyWhere . ' LIMIT 1'
        );
        $seen = [];
        $counts[$filename] = [
            'rows' => count($rows),
            'inserted' => 0,
            'skipped' => 0,
            'rejected' => 0,
            'pending' => 0,
        ];

        foreach ($rows as $item) {
            $row = $item['data'];
            $line = $item['line'];
            $invalidReason = validateScientificRow($row, $specification['kind']);
            $naturalIdentity = implode(':', array_map(
                static fn(string $key): string => (string)$row[$key],
                $specification['natural_key']
            ));
            if (isset($seen[$naturalIdentity])) {
                $invalidReason = 'duplicate natural key ' . $naturalIdentity;
            }
            $seen[$naturalIdentity] = true;

            if ($row['verification_status'] === 'rejected') {
                $invalidReason = 'record is marked rejected';
            }
            if ($invalidReason !== null) {
                $counts[$filename]['rejected']++;
                fwrite(STDERR, $filename . ' line ' . $line . ' rejected: ' . $invalidReason . PHP_EOL);
                continue;
            }

            $selectValues = [$row[$specification['primary_key']]];
            foreach ($specification['natural_key'] as $key) {
                $selectValues[] = $row[$key];
            }
            $select->execute($selectValues);
            $existing = $select->fetch(PDO::FETCH_ASSOC);
            if ($existing !== false) {
                if (!sameScientificRecord($existing, $row)) {
                    throw new RuntimeException(
                        $filename . ' line ' . $line . ' conflicts with an existing record; transaction rolled back.'
                    );
                }
                $counts[$filename]['skipped']++;
            } else {
                $insert->execute(array_values($row));
                $counts[$filename]['inserted']++;
            }

            if ($row['verification_status'] === 'pending verification') {
                $counts[$filename]['pending']++;
            }
        }
    }

    $pdo->commit();
} catch (Throwable $error) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    $importFailure = $error;
} finally {
    $release = $pdo->prepare('SELECT RELEASE_LOCK(?)');
    $release->execute([$lockName]);
}

if ($importFailure !== null) {
    fwrite(STDERR, 'Scientific dataset import failed: ' . $importFailure->getMessage() . PHP_EOL);
    exit(1);
}

foreach ($counts as $filename => $count) {
    fwrite(STDOUT, sprintf(
        "%s: %d rows; %d inserted; %d skipped; %d rejected; %d pending verification; 0 updated.\n",
        $filename,
        $count['rows'],
        $count['inserted'],
        $count['skipped'],
        $count['rejected'],
        $count['pending']
    ));
}
