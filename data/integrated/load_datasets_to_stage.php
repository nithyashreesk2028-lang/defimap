<?php
if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit('Not found.');
}

require __DIR__ . '/../../db.php';

$datasets = [
    'stage_deficiency_master' => [
        'file' => 'deficiency_master.csv',
        'columns' => ['deficiency_id', 'deficiency_name', 'description', 'related_nutrient', 'source_url'],
    ],
    'stage_symptom_master' => [
        'file' => 'symptom_master.csv',
        'columns' => ['symptom_id', 'symptom_name', 'description', 'source_url'],
    ],
    'stage_deficiency_symptoms' => [
        'file' => 'deficiency_symptoms.csv',
        'columns' => ['deficiency_id', 'symptom_id', 'weight', 'evidence_note', 'source_url'],
    ],
    'stage_food_recommendations' => [
        'file' => 'food_recommendations.csv',
        'columns' => ['deficiency_id', 'food_name', 'nutrient_name', 'benefit', 'caution', 'source_url'],
    ],
    'stage_gene_associations' => [
        'file' => 'gene_associations.csv',
        'columns' => ['association_id', 'deficiency_id', 'gene_symbol', 'gene_id', 'gene_name', 'association_description', 'source_url'],
    ],
    'stage_protein_associations' => [
        'file' => 'protein_associations.csv',
        'columns' => ['association_id', 'deficiency_id', 'protein_name', 'uniprot_accession', 'protein_function', 'association_description', 'source_url'],
    ],
    'stage_pathway_associations' => [
        'file' => 'pathway_associations.csv',
        'columns' => ['association_id', 'deficiency_id', 'pathway_name', 'pathway_id', 'pathway_description', 'source_url'],
    ],
    'stage_dataset_sources' => [
        'file' => 'dataset_sources.csv',
        'columns' => ['source_id', 'dataset_name', 'organization', 'source_url', 'record_identifier', 'version_or_release', 'access_date', 'license', 'verification_status'],
    ],
];

foreach ($datasets as $table => $dataset) {
    $path = __DIR__ . DIRECTORY_SEPARATOR . $dataset['file'];
    $handle = fopen($path, 'rb');
    if ($handle === false) {
        throw new RuntimeException('Unable to open ' . $dataset['file']);
    }
    $headers = fgetcsv($handle, 0, ',', '"', '');
    if (isset($headers[0])) {
        $headers[0] = preg_replace('/^\xEF\xBB\xBF/', '', $headers[0]);
    }
    if ($headers !== $dataset['columns']) {
        fclose($handle);
        throw new RuntimeException('Unexpected CSV headers in ' . $dataset['file']);
    }

    $columnSql = implode(', ', $dataset['columns']);
    $placeholders = implode(', ', array_fill(0, count($dataset['columns']), '?'));
    $insert = $pdo->prepare("INSERT INTO $table ($columnSql) VALUES ($placeholders)");

    $pdo->beginTransaction();
    try {
        $pdo->exec("DELETE FROM $table");
        $rowCount = 0;
        while (($values = fgetcsv($handle, 0, ',', '"', '')) !== false) {
            if (count($values) !== count($dataset['columns'])) {
                throw new RuntimeException(
                    $dataset['file'] . ' contains a row with an unexpected field count.'
                );
            }
            $insert->execute($values);
            $rowCount++;
        }
        $pdo->commit();
        fclose($handle);
        fwrite(STDOUT, "$table: staged $rowCount rows.\n");
    } catch (Throwable $error) {
        $pdo->rollBack();
        fclose($handle);
        throw $error;
    }
}

fwrite(STDOUT, "All eight CSV datasets are staged. Review validation.sql before running its merge statements.\n");
