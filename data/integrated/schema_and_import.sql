-- DefiMap dataset import: additive, preserving existing application tables.
-- Review validation_report.md first. No live table is dropped or overwritten.
-- All CREATE TABLE statements below are safe to rerun.

CREATE TABLE IF NOT EXISTS stage_deficiency_master (
    deficiency_id INT NOT NULL PRIMARY KEY,
    deficiency_name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    related_nutrient VARCHAR(100) NOT NULL,
    source_url VARCHAR(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS stage_symptom_master (
    symptom_id INT NOT NULL PRIMARY KEY,
    symptom_name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    source_url VARCHAR(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS stage_deficiency_symptoms (
    deficiency_id INT NOT NULL,
    symptom_id INT NOT NULL,
    weight INT NOT NULL,
    evidence_note TEXT NOT NULL,
    source_url VARCHAR(2048) NOT NULL,
    PRIMARY KEY (deficiency_id, symptom_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS stage_food_recommendations (
    deficiency_id INT NOT NULL,
    food_name VARCHAR(255) NOT NULL,
    nutrient_name VARCHAR(100) NOT NULL,
    benefit TEXT NOT NULL,
    caution TEXT NOT NULL,
    source_url VARCHAR(2048) NOT NULL,
    PRIMARY KEY (deficiency_id, food_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS stage_gene_associations (
    association_id INT NOT NULL PRIMARY KEY,
    deficiency_id INT NOT NULL,
    gene_symbol VARCHAR(30) NOT NULL,
    gene_id INT NOT NULL,
    gene_name VARCHAR(255) NOT NULL,
    association_description TEXT NOT NULL,
    source_url VARCHAR(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS stage_protein_associations (
    association_id INT NOT NULL PRIMARY KEY,
    deficiency_id INT NOT NULL,
    protein_name VARCHAR(255) NOT NULL,
    uniprot_accession VARCHAR(20) NOT NULL,
    protein_function TEXT NOT NULL,
    association_description TEXT NOT NULL,
    source_url VARCHAR(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS stage_pathway_associations (
    association_id INT NOT NULL PRIMARY KEY,
    deficiency_id INT NOT NULL,
    pathway_name VARCHAR(255) NOT NULL,
    pathway_id VARCHAR(100) NOT NULL DEFAULT '',
    pathway_description TEXT NOT NULL,
    source_url VARCHAR(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS stage_dataset_sources (
    source_id INT NOT NULL PRIMARY KEY,
    dataset_name VARCHAR(255) NOT NULL,
    organization VARCHAR(255) NOT NULL,
    source_url VARCHAR(2048) NOT NULL,
    record_identifier VARCHAR(255) NOT NULL,
    version_or_release VARCHAR(100) NOT NULL,
    access_date DATE NOT NULL,
    license TEXT NOT NULL,
    verification_status TEXT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Companion metadata tables keep the existing PHP-facing schemas unchanged.
CREATE TABLE IF NOT EXISTS deficiency_metadata (
    deficiency_id INT NOT NULL PRIMARY KEY,
    related_nutrient VARCHAR(100) NOT NULL,
    source_url VARCHAR(2048) NOT NULL,
    CONSTRAINT fk_deficiency_metadata_master
        FOREIGN KEY (deficiency_id) REFERENCES deficiency_master (deficiency_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS symptom_metadata (
    symptom_id INT NOT NULL PRIMARY KEY,
    description TEXT NOT NULL,
    source_url VARCHAR(2048) NOT NULL,
    CONSTRAINT fk_symptom_metadata_master
        FOREIGN KEY (symptom_id) REFERENCES symptom_master (symptom_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS deficiency_symptom_metadata (
    deficiency_id INT NOT NULL,
    symptom_id INT NOT NULL,
    evidence_note TEXT NOT NULL,
    source_url VARCHAR(2048) NOT NULL,
    PRIMARY KEY (deficiency_id, symptom_id),
    CONSTRAINT fk_deficiency_symptom_metadata_deficiency
        FOREIGN KEY (deficiency_id) REFERENCES deficiency_master (deficiency_id),
    CONSTRAINT fk_deficiency_symptom_metadata_symptom
        FOREIGN KEY (symptom_id) REFERENCES symptom_master (symptom_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS food_recommendation_metadata (
    food_recommendation_id INT NOT NULL PRIMARY KEY,
    nutrient_name VARCHAR(100) NOT NULL,
    source_url VARCHAR(2048) NOT NULL,
    CONSTRAINT fk_food_metadata_recommendation
        FOREIGN KEY (food_recommendation_id) REFERENCES food_recommendations (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS gene_association_metadata (
    association_id INT NOT NULL PRIMARY KEY,
    association_description TEXT NOT NULL,
    source_url VARCHAR(2048) NOT NULL,
    CONSTRAINT fk_gene_metadata_association
        FOREIGN KEY (association_id) REFERENCES gene_associations (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS protein_association_metadata (
    association_id INT NOT NULL PRIMARY KEY,
    protein_function TEXT NOT NULL,
    association_description TEXT NOT NULL,
    source_url VARCHAR(2048) NOT NULL,
    CONSTRAINT fk_protein_metadata_association
        FOREIGN KEY (association_id) REFERENCES protein_associations (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS pathway_association_metadata (
    association_id INT NOT NULL PRIMARY KEY,
    pathway_id VARCHAR(100) NOT NULL DEFAULT '',
    pathway_description TEXT NOT NULL,
    source_url VARCHAR(2048) NOT NULL,
    CONSTRAINT fk_pathway_metadata_association
        FOREIGN KEY (association_id) REFERENCES pathway_associations (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS dataset_sources (
    source_id INT NOT NULL PRIMARY KEY,
    dataset_name VARCHAR(255) NOT NULL,
    organization VARCHAR(255) NOT NULL,
    source_url VARCHAR(2048) NOT NULL,
    record_identifier VARCHAR(255) NOT NULL,
    version_or_release VARCHAR(100) NOT NULL,
    access_date DATE NOT NULL,
    license TEXT NOT NULL,
    verification_status TEXT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Import each UTF-8 CSV into its matching stage_* table using phpMyAdmin's
-- Import tab (CSV, first line contains column names), or use LOAD DATA LOCAL
-- INFILE after enabling local_infile in both the MySQL client and server.
--
-- Optional Windows LOAD DATA example:
-- LOAD DATA LOCAL INFILE 'C:\\xampp\\htdocs\\defimap\\data\\integrated\\deficiency_master.csv'
-- INTO TABLE stage_deficiency_master CHARACTER SET utf8mb4
-- FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
-- LINES TERMINATED BY '\r\n' IGNORE 1 LINES;
--
-- Repeat for each CSV and its corresponding stage table before running the
-- merge statements below. Clear a stage table before re-importing a CSV.

-- Preflight: resolve ID/name conflicts before merging. Any results require
-- manual review; do not continue by overwriting live records.
SELECT s.deficiency_id, s.deficiency_name, d.deficiency_name AS existing_name
FROM stage_deficiency_master s
JOIN deficiency_master d ON d.deficiency_id = s.deficiency_id
WHERE s.deficiency_name <> d.deficiency_name;

SELECT s.symptom_id, s.symptom_name, m.symptom_name AS existing_name
FROM stage_symptom_master s
JOIN symptom_master m ON m.symptom_id = s.symptom_id
WHERE s.symptom_name <> m.symptom_name;

-- Add master rows only when their IDs do not yet exist. No existing row is
-- overwritten. Resolve conflicting names from the preflight first.
INSERT INTO deficiency_master (deficiency_id, deficiency_name, description, cause)
SELECT s.deficiency_id, s.deficiency_name, s.description, ''
FROM stage_deficiency_master s
LEFT JOIN deficiency_master d ON d.deficiency_id = s.deficiency_id
WHERE d.deficiency_id IS NULL;

INSERT INTO symptom_master (symptom_id, symptom_name)
SELECT s.symptom_id, s.symptom_name
FROM stage_symptom_master s
LEFT JOIN symptom_master m ON m.symptom_id = s.symptom_id
WHERE m.symptom_id IS NULL;

INSERT INTO deficiency_metadata (deficiency_id, related_nutrient, source_url)
SELECT s.deficiency_id, s.related_nutrient, s.source_url
FROM stage_deficiency_master s
JOIN deficiency_master d ON d.deficiency_id = s.deficiency_id
ON DUPLICATE KEY UPDATE
    related_nutrient = VALUES(related_nutrient),
    source_url = VALUES(source_url);

INSERT INTO symptom_metadata (symptom_id, description, source_url)
SELECT s.symptom_id, s.description, s.source_url
FROM stage_symptom_master s
JOIN symptom_master m ON m.symptom_id = s.symptom_id
ON DUPLICATE KEY UPDATE
    description = VALUES(description),
    source_url = VALUES(source_url);

-- Preserve existing project weights; add only missing mapping pairs.
INSERT INTO deficiency_symptoms (deficiency_id, symptom_id, weight)
SELECT s.deficiency_id, s.symptom_id, s.weight
FROM stage_deficiency_symptoms s
JOIN deficiency_master d ON d.deficiency_id = s.deficiency_id
JOIN symptom_master m ON m.symptom_id = s.symptom_id
WHERE NOT EXISTS (
    SELECT 1 FROM deficiency_symptoms existing
    WHERE existing.deficiency_id = s.deficiency_id
      AND existing.symptom_id = s.symptom_id
);

INSERT INTO deficiency_symptom_metadata (deficiency_id, symptom_id, evidence_note, source_url)
SELECT s.deficiency_id, s.symptom_id, s.evidence_note, s.source_url
FROM stage_deficiency_symptoms s
JOIN deficiency_symptoms existing
  ON existing.deficiency_id = s.deficiency_id
 AND existing.symptom_id = s.symptom_id
GROUP BY s.deficiency_id, s.symptom_id, s.evidence_note, s.source_url
ON DUPLICATE KEY UPDATE
    evidence_note = VALUES(evidence_note),
    source_url = VALUES(source_url);

-- Never replace existing food text. Only food recommendations not already
-- present for the same deficiency and case-insensitive food name are inserted.
INSERT INTO food_recommendations (deficiency_id, food_name, benefits, avoid_food)
SELECT s.deficiency_id, s.food_name, s.benefit, s.caution
FROM stage_food_recommendations s
JOIN deficiency_master d ON d.deficiency_id = s.deficiency_id
WHERE NOT EXISTS (
    SELECT 1 FROM food_recommendations existing
    WHERE existing.deficiency_id = s.deficiency_id
      AND LOWER(TRIM(existing.food_name)) = LOWER(TRIM(s.food_name))
);

INSERT INTO food_recommendation_metadata (food_recommendation_id, nutrient_name, source_url)
SELECT existing.id, s.nutrient_name, s.source_url
FROM stage_food_recommendations s
JOIN food_recommendations existing
  ON existing.deficiency_id = s.deficiency_id
 AND LOWER(TRIM(existing.food_name)) = LOWER(TRIM(s.food_name))
GROUP BY existing.id, s.nutrient_name, s.source_url
ON DUPLICATE KEY UPDATE
    nutrient_name = VALUES(nutrient_name),
    source_url = VALUES(source_url);

-- Existing association IDs are preserved. Run the conflict checks in the
-- validation queries before inserting records into the live association tables.
INSERT INTO gene_associations (id, deficiency_id, gene_symbol, gene_name, ncbi_gene_id)
SELECT s.association_id, s.deficiency_id, s.gene_symbol, s.gene_name, s.gene_id
FROM stage_gene_associations s
LEFT JOIN gene_associations existing ON existing.id = s.association_id
WHERE existing.id IS NULL;

INSERT INTO gene_association_metadata (association_id, association_description, source_url)
SELECT s.association_id, s.association_description, s.source_url
FROM stage_gene_associations s
JOIN gene_associations existing
  ON existing.id = s.association_id
 AND existing.deficiency_id = s.deficiency_id
 AND existing.gene_symbol = s.gene_symbol
ON DUPLICATE KEY UPDATE
    association_description = VALUES(association_description),
    source_url = VALUES(source_url);

INSERT INTO protein_associations (id, deficiency_id, protein_name, uniprot_accession)
SELECT s.association_id, s.deficiency_id, s.protein_name, s.uniprot_accession
FROM stage_protein_associations s
LEFT JOIN protein_associations existing ON existing.id = s.association_id
WHERE existing.id IS NULL;

INSERT INTO protein_association_metadata
    (association_id, protein_function, association_description, source_url)
SELECT s.association_id, s.protein_function, s.association_description, s.source_url
FROM stage_protein_associations s
JOIN protein_associations existing
  ON existing.id = s.association_id
 AND existing.deficiency_id = s.deficiency_id
 AND existing.uniprot_accession = s.uniprot_accession
ON DUPLICATE KEY UPDATE
    protein_function = VALUES(protein_function),
    association_description = VALUES(association_description),
    source_url = VALUES(source_url);

INSERT INTO pathway_associations (id, deficiency_id, pathway_name)
SELECT s.association_id, s.deficiency_id, s.pathway_name
FROM stage_pathway_associations s
LEFT JOIN pathway_associations existing ON existing.id = s.association_id
WHERE existing.id IS NULL;

INSERT INTO pathway_association_metadata
    (association_id, pathway_id, pathway_description, source_url)
SELECT s.association_id, s.pathway_id, s.pathway_description, s.source_url
FROM stage_pathway_associations s
JOIN pathway_associations existing
  ON existing.id = s.association_id
 AND existing.deficiency_id = s.deficiency_id
 AND existing.pathway_name = s.pathway_name
ON DUPLICATE KEY UPDATE
    pathway_id = VALUES(pathway_id),
    pathway_description = VALUES(pathway_description),
    source_url = VALUES(source_url);

INSERT INTO dataset_sources
    (source_id, dataset_name, organization, source_url, record_identifier,
     version_or_release, access_date, license, verification_status)
SELECT source_id, dataset_name, organization, source_url, record_identifier,
       version_or_release, access_date, license, verification_status
FROM stage_dataset_sources
ON DUPLICATE KEY UPDATE
    dataset_name = VALUES(dataset_name),
    organization = VALUES(organization),
    source_url = VALUES(source_url),
    record_identifier = VALUES(record_identifier),
    version_or_release = VALUES(version_or_release),
    access_date = VALUES(access_date),
    license = VALUES(license),
    verification_status = VALUES(verification_status);

-- Auto-increment columns with explicit imported IDs advance on supported
-- MySQL/MariaDB versions. Inspect MAX(id) and AUTO_INCREMENT before further
-- inserts if this pack is imported into a different database.
