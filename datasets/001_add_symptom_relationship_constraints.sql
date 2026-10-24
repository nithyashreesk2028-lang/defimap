-- One-time additive migration for the existing symptom relationship table.
-- Run only after reviewing the preflight counts below. The ALTER statement
-- fails without changing rows if any nulls, orphans, or duplicate pairs exist.

SELECT
    (SELECT COUNT(*) FROM deficiency_symptoms
     WHERE deficiency_id IS NULL OR symptom_id IS NULL OR weight IS NULL) AS null_relationship_fields,
    (SELECT COUNT(*) FROM deficiency_symptoms ds
     LEFT JOIN deficiency_master d ON d.deficiency_id = ds.deficiency_id
     WHERE d.deficiency_id IS NULL) AS missing_deficiencies,
    (SELECT COUNT(*) FROM deficiency_symptoms ds
     LEFT JOIN symptom_master s ON s.symptom_id = ds.symptom_id
     WHERE s.symptom_id IS NULL) AS missing_symptoms,
    (SELECT COUNT(*) FROM (
        SELECT deficiency_id, symptom_id
        FROM deficiency_symptoms
        GROUP BY deficiency_id, symptom_id
        HAVING COUNT(*) > 1
    ) AS duplicate_pairs) AS duplicate_relationships;

ALTER TABLE deficiency_symptoms
    MODIFY deficiency_id INT(11) NOT NULL,
    MODIFY symptom_id INT(11) NOT NULL,
    MODIFY weight INT(11) NOT NULL,
    ADD UNIQUE KEY uq_deficiency_symptom_pair (deficiency_id, symptom_id),
    ADD CONSTRAINT fk_deficiency_symptoms_deficiency
        FOREIGN KEY (deficiency_id) REFERENCES deficiency_master (deficiency_id),
    ADD CONSTRAINT fk_deficiency_symptoms_symptom
        FOREIGN KEY (symptom_id) REFERENCES symptom_master (symptom_id);
