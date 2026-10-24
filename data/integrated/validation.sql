-- Run after importing CSVs into stage_* tables.

-- Counts should match the generated pack: 20, 20, 48, 85, 5, 5, 4, 38.
SELECT 'deficiency_master' AS dataset, COUNT(*) AS row_count FROM stage_deficiency_master
UNION ALL SELECT 'symptom_master', COUNT(*) FROM stage_symptom_master
UNION ALL SELECT 'deficiency_symptoms', COUNT(*) FROM stage_deficiency_symptoms
UNION ALL SELECT 'food_recommendations', COUNT(*) FROM stage_food_recommendations
UNION ALL SELECT 'gene_associations', COUNT(*) FROM stage_gene_associations
UNION ALL SELECT 'protein_associations', COUNT(*) FROM stage_protein_associations
UNION ALL SELECT 'pathway_associations', COUNT(*) FROM stage_pathway_associations
UNION ALL SELECT 'dataset_sources', COUNT(*) FROM stage_dataset_sources;

-- Duplicate names and logical keys.
SELECT deficiency_name, COUNT(*) AS duplicate_count
FROM stage_deficiency_master
GROUP BY deficiency_name
HAVING COUNT(*) > 1;

SELECT symptom_name, COUNT(*) AS duplicate_count
FROM stage_symptom_master
GROUP BY symptom_name
HAVING COUNT(*) > 1;

SELECT deficiency_id, symptom_id, COUNT(*) AS duplicate_count
FROM stage_deficiency_symptoms
GROUP BY deficiency_id, symptom_id
HAVING COUNT(*) > 1;

SELECT deficiency_id, LOWER(TRIM(food_name)) AS normalized_food, COUNT(*) AS duplicate_count
FROM stage_food_recommendations
GROUP BY deficiency_id, LOWER(TRIM(food_name))
HAVING COUNT(*) > 1;

-- Invalid foreign-key references within the imported files.
SELECT 'deficiency_symptoms.deficiency_id' AS invalid_reference, s.deficiency_id AS missing_id
FROM stage_deficiency_symptoms s
LEFT JOIN stage_deficiency_master d ON d.deficiency_id = s.deficiency_id
WHERE d.deficiency_id IS NULL
UNION ALL
SELECT 'deficiency_symptoms.symptom_id', s.symptom_id
FROM stage_deficiency_symptoms s
LEFT JOIN stage_symptom_master m ON m.symptom_id = s.symptom_id
WHERE m.symptom_id IS NULL
UNION ALL
SELECT 'food_recommendations.deficiency_id', f.deficiency_id
FROM stage_food_recommendations f
LEFT JOIN stage_deficiency_master d ON d.deficiency_id = f.deficiency_id
WHERE d.deficiency_id IS NULL
UNION ALL
SELECT 'gene_associations.deficiency_id', g.deficiency_id
FROM stage_gene_associations g
LEFT JOIN stage_deficiency_master d ON d.deficiency_id = g.deficiency_id
WHERE d.deficiency_id IS NULL
UNION ALL
SELECT 'protein_associations.deficiency_id', p.deficiency_id
FROM stage_protein_associations p
LEFT JOIN stage_deficiency_master d ON d.deficiency_id = p.deficiency_id
WHERE d.deficiency_id IS NULL
UNION ALL
SELECT 'pathway_associations.deficiency_id', p.deficiency_id
FROM stage_pathway_associations p
LEFT JOIN stage_deficiency_master d ON d.deficiency_id = p.deficiency_id
WHERE d.deficiency_id IS NULL;

-- Missing source URLs are expected only for rows whose identifiers are
-- explicitly unresolved; pathway_id is intentionally blank if not verified.
SELECT 'deficiency_master' AS dataset, deficiency_id AS row_id
FROM stage_deficiency_master WHERE TRIM(source_url) = ''
UNION ALL
SELECT 'symptom_master', symptom_id FROM stage_symptom_master WHERE TRIM(source_url) = ''
UNION ALL
SELECT 'deficiency_symptoms', deficiency_id
FROM stage_deficiency_symptoms WHERE TRIM(source_url) = ''
UNION ALL
SELECT 'food_recommendations', deficiency_id
FROM stage_food_recommendations WHERE TRIM(source_url) = ''
UNION ALL
SELECT 'gene_associations', association_id
FROM stage_gene_associations WHERE TRIM(source_url) = ''
UNION ALL
SELECT 'protein_associations', association_id
FROM stage_protein_associations WHERE TRIM(source_url) = ''
UNION ALL
SELECT 'pathway_associations', association_id
FROM stage_pathway_associations WHERE TRIM(source_url) = ''
UNION ALL
SELECT 'dataset_sources', source_id
FROM stage_dataset_sources
WHERE TRIM(source_url) = '' AND organization <> 'DefiMap local project database';

-- Existing-ID conflicts must return zero rows before the merge.
SELECT s.deficiency_id, s.deficiency_name AS imported_name, d.deficiency_name AS existing_name
FROM stage_deficiency_master s
JOIN deficiency_master d ON d.deficiency_id = s.deficiency_id
WHERE s.deficiency_name <> d.deficiency_name;

SELECT s.symptom_id, s.symptom_name AS imported_name, m.symptom_name AS existing_name
FROM stage_symptom_master s
JOIN symptom_master m ON m.symptom_id = s.symptom_id
WHERE s.symptom_name <> m.symptom_name;

SELECT s.association_id, 'gene' AS association_type
FROM stage_gene_associations s
JOIN gene_associations g ON g.id = s.association_id
WHERE g.deficiency_id <> s.deficiency_id
   OR g.gene_symbol <> s.gene_symbol
   OR COALESCE(g.ncbi_gene_id, 0) <> COALESCE(s.gene_id, 0)
UNION ALL
SELECT s.association_id, 'protein'
FROM stage_protein_associations s
JOIN protein_associations p ON p.id = s.association_id
WHERE p.deficiency_id <> s.deficiency_id
   OR COALESCE(p.uniprot_accession, '') <> s.uniprot_accession
UNION ALL
SELECT s.association_id, 'pathway'
FROM stage_pathway_associations s
JOIN pathway_associations p ON p.id = s.association_id
WHERE p.deficiency_id <> s.deficiency_id
   OR COALESCE(p.pathway_name, '') <> s.pathway_name;

-- Example joined view of recommendations and their nutrient labels after
-- importing metadata. This does not modify the existing report page.
SELECT d.deficiency_name, f.food_name, f.benefits, f.avoid_food,
       fm.nutrient_name, fm.source_url
FROM food_recommendations f
JOIN deficiency_master d ON d.deficiency_id = f.deficiency_id
LEFT JOIN food_recommendation_metadata fm ON fm.food_recommendation_id = f.id
ORDER BY d.deficiency_name, f.food_name;
