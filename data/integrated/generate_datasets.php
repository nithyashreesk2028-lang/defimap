<?php
if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit('Not found.');
}

require __DIR__ . '/../../db.php';

$outputDirectory = __DIR__;
$accessDate = '2026-10-18';
$nutrients = [
    1 => ['Iron', 'Iron'],
    2 => ['Vitamin D', 'VitaminD'],
    3 => ['Vitamin B12', 'VitaminB12'],
    4 => ['Vitamin A', 'VitaminA'],
    5 => ['Vitamin C', 'VitaminC'],
    6 => ['Vitamin E', 'VitaminE'],
    7 => ['Vitamin K', 'VitaminK'],
    8 => ['Vitamin B1 (thiamin)', 'Thiamin'],
    9 => ['Vitamin B2 (riboflavin)', 'Riboflavin'],
    10 => ['Vitamin B3 (niacin)', 'Niacin'],
    11 => ['Vitamin B6', 'VitaminB6'],
    12 => ['Biotin', 'Biotin'],
    13 => ['Folate', 'Folate'],
    14 => ['Calcium', 'Calcium'],
    15 => ['Magnesium', 'Magnesium'],
    16 => ['Zinc', 'Zinc'],
    17 => ['Copper', 'Copper'],
    18 => ['Iodine', 'Iodine'],
    19 => ['Selenium', 'Selenium'],
    20 => ['Potassium', 'Potassium'],
];
$odsUrlForId = [];
foreach ($nutrients as $id => $nutrient) {
    $odsUrlForId[$id] = 'https://ods.od.nih.gov/factsheets/' . $nutrient[1] . '-HealthProfessional/';
}

$symptomDescriptions = [
    'Fatigue' => 'Feeling unusually tired or lacking energy; nonspecific and may have many causes.',
    'Weakness' => 'Reduced strength; nonspecific and may have many causes.',
    'Hair Loss' => 'Increased hair shedding or loss; has many possible causes.',
    'Pale Skin' => 'Paler-than-usual skin appearance; has many possible causes.',
    'Bone Pain' => 'Pain felt in bone; has many possible causes and requires appropriate assessment.',
    'Muscle Cramps' => 'Sudden involuntary muscle contraction; has many possible causes.',
    'Dry Skin' => 'Dry or rough skin; has many possible causes.',
    'Night Blindness' => 'Difficulty seeing in low light; requires professional assessment.',
    'Bleeding Gums' => 'Bleeding from the gums; dental and other causes are common.',
    'Mouth Ulcers' => 'Sores inside the mouth; have many possible causes.',
    'Numbness' => 'Reduced or altered sensation; cause and urgency depend on the situation.',
    'Dizziness' => 'A feeling of faintness, unsteadiness, or motion; has many possible causes.',
    'Poor Wound Healing' => 'A wound healing more slowly than expected; has many possible causes.',
    'Frequent Infections' => 'Repeated infections; a nonspecific finding that warrants context.',
    'Loss of Appetite' => 'Reduced desire to eat; has many possible causes.',
    'Depression' => 'Persistent low mood or loss of interest; requires appropriate mental-health assessment.',
    'Brittle Nails' => 'Nails that split, peel, or break easily; has many possible causes.',
    'Shortness of Breath' => 'Breathing discomfort or difficulty; may require urgent medical attention.',
    'Headache' => 'Pain or discomfort in the head; has many possible causes.',
    'Weight Loss' => 'Unintended decrease in body weight; has many possible causes.',
];

$geneDescriptions = [
    'HAMP' => 'Encodes hepcidin, a hormone that regulates systemic iron availability and iron export; this is a biological iron-homeostasis relationship, not proof that dietary iron deficiency is caused by this gene.',
    'HFE' => 'Participates in iron sensing and regulation; variation can affect iron homeostasis, but the association does not establish nutritional deficiency.',
    'SLC40A1' => 'Encodes ferroportin, a cellular iron exporter involved in iron transport; the association is mechanistic and not a diagnosis.',
    'TF' => 'Encodes transferrin, which transports iron in blood; this function is relevant to iron physiology but does not show that low dietary iron is gene-caused.',
    'TFR2' => 'Encodes transferrin receptor 2, involved in iron sensing and regulation of hepcidin; this is a biological pathway association, not a diagnosis.',
];

$proteinFunctions = [
    'P02794' => ['Ferritin heavy chain', 'Ferritin stores iron intracellularly and helps manage iron availability.'],
    'Q9NP59' => ['Ferroportin', 'Ferroportin exports iron from cells and is encoded by SLC40A1.'],
    'P81172' => ['Hepcidin', 'Hepcidin is a peptide hormone that regulates iron export and systemic iron availability.'],
    'P02787' => ['Transferrin', 'Transferrin binds and transports iron in blood.'],
    'Q9UP52' => ['Transferrin receptor 2', 'Transferrin receptor 2 participates in cellular iron sensing and regulation.'],
];

$pathwayDescriptions = [
    'Cellular Iron Uptake' => 'Pathway label exported from the existing application database. Exact Reactome pathway correspondence and identifier have not been independently established.',
    'Erythropoiesis' => 'Biological process label exported from the existing application database. Exact Reactome pathway correspondence and identifier have not been independently established.',
    'HIF-1 Signaling Pathway' => 'Pathway label exported from the existing application database. Exact Reactome pathway correspondence and identifier have not been independently established.',
    'Iron Homeostasis' => 'Biological process label exported from the existing application database. Exact Reactome pathway correspondence and identifier have not been independently established.',
];

function exportCsv(string $filename, array $headers, iterable $rows): void
{
    global $outputDirectory;
    $path = $outputDirectory . DIRECTORY_SEPARATOR . $filename;
    $handle = fopen($path, 'wb');
    if ($handle === false) {
        throw new RuntimeException('Unable to create dataset file: ' . $path);
    }

    fwrite($handle, "\xEF\xBB\xBF");
    fputcsv($handle, $headers, ',', '"', '');
    foreach ($rows as $row) {
        fputcsv($handle, $row, ',', '"', '');
    }
    fclose($handle);
}

$deficiencies = $pdo->query(
    "SELECT deficiency_id, deficiency_name, description
     FROM deficiency_master
     ORDER BY deficiency_id"
)->fetchAll(PDO::FETCH_ASSOC);
$symptoms = $pdo->query(
    "SELECT symptom_id, symptom_name
     FROM symptom_master
     ORDER BY symptom_id"
)->fetchAll(PDO::FETCH_ASSOC);

$deficiencyById = [];
foreach ($deficiencies as $deficiency) {
    $deficiencyById[(int)$deficiency['deficiency_id']] = $deficiency;
}

$deficiencyCsv = [];
foreach ($deficiencies as $deficiency) {
    $id = (int)$deficiency['deficiency_id'];
    $nutrient = $nutrients[$id] ?? [preg_replace('/\s+Deficiency$/', '', $deficiency['deficiency_name']), ''];
    $description = trim((string)$deficiency['description']);
    if ($description === '') {
        $description = 'Inadequate availability of ' . $nutrient[0] . '; clinical status requires appropriate assessment.';
    }
    $deficiencyCsv[] = [
        $id,
        $deficiency['deficiency_name'],
        $description,
        $nutrient[0],
        $odsUrlForId[$id] ?? '',
    ];
}
exportCsv('deficiency_master.csv', [
    'deficiency_id', 'deficiency_name', 'description', 'related_nutrient', 'source_url',
], $deficiencyCsv);

$symptomCsv = [];
foreach ($symptoms as $symptom) {
    $name = $symptom['symptom_name'];
    $symptomCsv[] = [
        (int)$symptom['symptom_id'],
        $name,
        $symptomDescriptions[$name] ?? 'Symptom label from the existing application; nonspecific and not diagnostic.',
        'https://medlineplus.gov/symptoms.html',
    ];
}
exportCsv('symptom_master.csv', [
    'symptom_id', 'symptom_name', 'description', 'source_url',
], $symptomCsv);

$mappingRows = $pdo->query(
    "SELECT ds.deficiency_id, ds.symptom_id, ds.weight, d.deficiency_name, s.symptom_name
     FROM deficiency_symptoms ds
     JOIN deficiency_master d ON d.deficiency_id = ds.deficiency_id
     JOIN symptom_master s ON s.symptom_id = ds.symptom_id
     ORDER BY ds.deficiency_id, ds.symptom_id, ds.id"
)->fetchAll(PDO::FETCH_ASSOC);
$mappingCsv = [];
foreach ($mappingRows as $mapping) {
    $weight = (int)$mapping['weight'];
    $mappingCsv[] = [
        (int)$mapping['deficiency_id'],
        (int)$mapping['symptom_id'],
        $weight,
        'Existing DefiMap rule weight ' . $weight . '/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.',
        $odsUrlForId[(int)$mapping['deficiency_id']] ?? '',
    ];
}
exportCsv('deficiency_symptoms.csv', [
    'deficiency_id', 'symptom_id', 'weight', 'evidence_note', 'source_url',
], $mappingCsv);

$foodRows = $pdo->query(
    "SELECT deficiency_id, food_name, benefits, avoid_food
     FROM food_recommendations
     ORDER BY deficiency_id, food_name, id"
)->fetchAll(PDO::FETCH_ASSOC);
$foodCsv = [];
foreach ($foodRows as $food) {
    $id = (int)$food['deficiency_id'];
    $deficiencyName = $deficiencyById[$id]['deficiency_name'] ?? '';
    $nutrient = $nutrients[$id][0] ?? preg_replace('/\s+Deficiency$/', '', $deficiencyName);
    $foodCsv[] = [
        $id,
        $food['food_name'],
        $nutrient,
        $food['benefits'],
        $food['avoid_food'],
        $odsUrlForId[$id] ?? '',
    ];
}
exportCsv('food_recommendations.csv', [
    'deficiency_id', 'food_name', 'nutrient_name', 'benefit', 'caution', 'source_url',
], $foodCsv);

$geneRows = $pdo->query(
    "SELECT id, deficiency_id, gene_symbol, gene_name, ncbi_gene_id
     FROM gene_associations
     ORDER BY deficiency_id, gene_symbol, id"
)->fetchAll(PDO::FETCH_ASSOC);
$geneCsv = [];
foreach ($geneRows as $gene) {
    $geneId = $gene['ncbi_gene_id'] === null ? '' : (int)$gene['ncbi_gene_id'];
    $geneCsv[] = [
        (int)$gene['id'],
        (int)$gene['deficiency_id'],
        $gene['gene_symbol'],
        $geneId,
        $gene['gene_name'],
        $geneDescriptions[$gene['gene_symbol']] ?? 'Existing application association; biological relationship requires source-level review.',
        $geneId === '' ? '' : 'https://www.ncbi.nlm.nih.gov/gene/' . $geneId,
    ];
}
exportCsv('gene_associations.csv', [
    'association_id', 'deficiency_id', 'gene_symbol', 'gene_id', 'gene_name',
    'association_description', 'source_url',
], $geneCsv);

$proteinRows = $pdo->query(
    "SELECT id, deficiency_id, protein_name, uniprot_accession
     FROM protein_associations
     ORDER BY deficiency_id, protein_name, id"
)->fetchAll(PDO::FETCH_ASSOC);
$proteinCsv = [];
foreach ($proteinRows as $protein) {
    $accession = (string)($protein['uniprot_accession'] ?? '');
    $knownProtein = $proteinFunctions[$accession] ?? [$protein['protein_name'], 'Existing application protein association; function and accession require source-level review.'];
    $proteinCsv[] = [
        (int)$protein['id'],
        (int)$protein['deficiency_id'],
        $protein['protein_name'],
        $accession,
        $knownProtein[1],
        'Biological iron-related function is provided as context only; this association does not establish a cause or diagnosis of nutritional deficiency.',
        $accession === '' ? '' : 'https://www.uniprot.org/uniprotkb/' . rawurlencode($accession),
    ];
}
exportCsv('protein_associations.csv', [
    'association_id', 'deficiency_id', 'protein_name', 'uniprot_accession',
    'protein_function', 'association_description', 'source_url',
], $proteinCsv);

$pathwayRows = $pdo->query(
    "SELECT id, deficiency_id, pathway_name
     FROM pathway_associations
     ORDER BY deficiency_id, pathway_name, id"
)->fetchAll(PDO::FETCH_ASSOC);
$pathwayCsv = [];
foreach ($pathwayRows as $pathway) {
    $name = (string)$pathway['pathway_name'];
    $pathwayCsv[] = [
        (int)$pathway['id'],
        (int)$pathway['deficiency_id'],
        $name,
        '',
        $pathwayDescriptions[$name] ?? 'Existing application pathway label; exact Reactome mapping has not been independently established.',
        'https://reactome.org/',
    ];
}
exportCsv('pathway_associations.csv', [
    'association_id', 'deficiency_id', 'pathway_name', 'pathway_id',
    'pathway_description', 'source_url',
], $pathwayCsv);

$sourceRows = [
    [
        1, 'Deficiency, symptom, and association masters', 'DefiMap local project database',
        '', 'Current live rows in deficiency_master, symptom_master, and deficiency_symptoms',
        'Unknown', $accessDate, 'Unknown; project reuse terms not supplied',
        'Exported from local schema; scientific source verification remains incomplete.',
    ],
    [
        2, 'Food recommendations', 'DefiMap local project database',
        '', 'Current live food_recommendations rows',
        'Unknown', $accessDate, 'Unknown; project reuse terms not supplied',
        'Exported without overwriting records; food descriptions need claim-level review.',
    ],
    [
        3, 'Food composition reference', 'USDA Agricultural Research Service, FoodData Central',
        'https://fdc.nal.usda.gov/', 'No FoodData Central record IDs or nutrient quantities imported',
        'Unknown', $accessDate, 'CC0 1.0 Universal; USDA requests attribution',
        'Official licensing page states USDA FDC data are public domain and CC0; source-checked values and per-100-g records are stored separately in datasets/food_nutrient_data.csv.',
    ],
    [
        4, 'Symptom terminology', 'U.S. National Library of Medicine, MedlinePlus',
        'https://medlineplus.gov/symptoms.html', 'General symptoms information page',
        'Unknown', $accessDate, 'U.S. government-created NLM content is public domain; third-party content may have separate restrictions',
        'Official MedlinePlus symptoms entry point recorded; individual symptom definitions are cautious project glosses, not copied clinical text.',
    ],
];
$sourceId = 5;
foreach ($nutrients as $id => $nutrient) {
    $sourceRows[] = [
        $sourceId++,
        'Deficiency master, symptom mapping, and food context',
        'NIH Office of Dietary Supplements',
        $odsUrlForId[$id],
        $nutrient[1] . '-HealthProfessional',
        'Unknown',
        $accessDate,
        'Unknown; page-specific reuse notices and third-party materials require review',
        'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.',
    ];
}
foreach ($geneRows as $gene) {
    $geneId = (string)($gene['ncbi_gene_id'] ?? '');
    $sourceRows[] = [
        $sourceId++,
        'Gene associations',
        'NCBI Gene / National Center for Biotechnology Information',
        $geneId === '' ? '' : 'https://www.ncbi.nlm.nih.gov/gene/' . $geneId,
        'NCBI Gene ' . ($geneId === '' ? 'identifier missing in the existing project record' : $geneId),
        'Unknown',
        $accessDate,
        'NCBI places no restrictions on molecular database data; submitter and third-party rights may still apply',
        'Identifier and record URL are retained from the current project data; verify the live NCBI record and any submitter notices before reuse.',
    ];
}
foreach ($proteinRows as $protein) {
    $accession = (string)($protein['uniprot_accession'] ?? '');
    $sourceRows[] = [
        $sourceId++,
        'Protein associations',
        'UniProt Consortium',
        $accession === '' ? '' : 'https://www.uniprot.org/uniprotkb/' . rawurlencode($accession),
        'UniProt accession ' . ($accession === '' ? 'missing in the existing project record' : $accession),
        'Unknown',
        $accessDate,
        'Unknown; verify current UniProtKB license and attribution terms before redistribution',
        'Accession and record URL are retained from the current project data; confirm the live UniProt record and current license before reuse.',
    ];
}
foreach ($pathwayRows as $pathway) {
    $name = (string)$pathway['pathway_name'];
    $sourceRows[] = [
        $sourceId++,
        'Biological pathway associations',
        'Reactome',
        'https://reactome.org/',
        'Existing local label: ' . $name,
        'Unknown',
        $accessDate,
        'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms',
        'Reactome license reviewed; no exact Reactome identifier is asserted for this local label.',
    ];
}
exportCsv('dataset_sources.csv', [
    'source_id', 'dataset_name', 'organization', 'source_url', 'record_identifier',
    'version_or_release', 'access_date', 'license', 'verification_status',
], $sourceRows);

fwrite(STDOUT, 'Exported ' . count($deficiencies) . ' deficiencies, ' . count($symptoms) . ' symptoms, '
    . count($mappingRows) . ' existing symptom mappings, ' . count($foodRows) . ' food recommendations, '
    . count($geneRows) . ' genes, ' . count($proteinRows) . ' proteins, '
    . count($pathwayRows) . ' pathways, and ' . count($sourceRows) . " provenance records.\n");
