-- Additive tables for the directly source-checked USDA and PubChem records.
-- Existing application tables and their records are not modified.

CREATE TABLE IF NOT EXISTS food_nutrient_data (
    food_record_id INT NOT NULL PRIMARY KEY,
    fdc_id INT NOT NULL,
    food_name VARCHAR(255) NOT NULL,
    nutrient_name VARCHAR(255) NOT NULL,
    nutrient_amount DECIMAL(18,8) NOT NULL,
    nutrient_unit VARCHAR(20) NOT NULL,
    serving_basis VARCHAR(100) NOT NULL,
    source_url VARCHAR(2048) NOT NULL,
    verification_status VARCHAR(40) NOT NULL,
    UNIQUE KEY uq_food_nutrient_fdc_nutrient (fdc_id, nutrient_name),
    KEY ix_food_nutrient_name (nutrient_name),
    KEY ix_food_nutrient_fdc_id (fdc_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS compound_data (
    compound_id INT NOT NULL PRIMARY KEY,
    pubchem_cid BIGINT NOT NULL,
    compound_name VARCHAR(255) NOT NULL,
    molecular_formula VARCHAR(100) NOT NULL,
    molecular_weight DECIMAL(18,8) NOT NULL,
    related_nutrient VARCHAR(100) NOT NULL,
    source_url VARCHAR(2048) NOT NULL,
    verification_status VARCHAR(40) NOT NULL,
    UNIQUE KEY uq_compound_pubchem_cid (pubchem_cid),
    KEY ix_compound_related_nutrient (related_nutrient)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
