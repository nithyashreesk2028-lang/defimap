# DefiMap integrated datasets

Generated from the live `defimap` database by `generate_datasets.php`. The CSVs are UTF-8 with a byte-order mark for common spreadsheet compatibility. They are exports of the existing project records plus explicitly labeled explanatory metadata; they are not a clinical reference standard.

## CSV columns

| Dataset | Column | CSV type | Meaning |
|---|---|---|---|
| `deficiency_master.csv` | `deficiency_id` | integer | Existing primary key from `deficiency_master`. |
| | `deficiency_name` | text | Existing category name. |
| | `description` | text | Existing database description; blank source descriptions remain blank if present. |
| | `related_nutrient` | text | Nutrient label corresponding to the existing category. |
| | `source_url` | URL/text | NIH ODS health-professional fact-sheet URL for background. The target pages returned HTTP 403 in this collection run, so page content and each individual claim were not verified here. |
| `symptom_master.csv` | `symptom_id` | integer | Existing primary key from `symptom_master`. |
| | `symptom_name` | text | Existing symptom label. |
| | `description` | text | Cautious, plain-language gloss; symptoms are nonspecific and not diagnoses. |
| | `source_url` | URL/text | MedlinePlus symptoms entry point, not a claim-specific article citation. |
| `deficiency_symptoms.csv` | `deficiency_id` | integer | Foreign-key value for `deficiency_master.deficiency_id`. |
| | `symptom_id` | integer | Foreign-key value for `symptom_master.symptom_id`. |
| | `weight` | integer | Existing DefiMap project rule weight, exported unchanged. It is not a probability, clinical severity, or validated diagnostic score. |
| | `evidence_note` | text | Explicitly states that the legacy rule has not been independently validated; the linked ODS page is background only. |
| | `source_url` | URL/text | ODS background page for the mapped nutrient; it does not substantiate the individual pair. |
| `food_recommendations.csv` | `deficiency_id` | integer | Foreign-key value for `deficiency_master.deficiency_id`. |
| | `food_name` | text | Existing food recommendation name. |
| | `nutrient_name` | text | Nutrient label for the deficiency category. |
| | `benefit` | text | Existing `food_recommendations.benefits` content. |
| | `caution` | text | Existing `food_recommendations.avoid_food` content. This is a caution field, not an instruction that every person must avoid the food. |
| | `source_url` | URL/text | ODS background page for the nutrient. This recommendation snapshot is not automatically matched to FoodData Central IDs or measurements. |
| `gene_associations.csv` | `association_id` | integer | Existing `gene_associations.id`; preserve as the row key when importing this snapshot. |
| | `deficiency_id` | integer | Foreign-key value for `deficiency_master.deficiency_id`. |
| | `gene_symbol` | text | Existing gene symbol. |
| | `gene_id` | integer/text | Existing NCBI Gene identifier (`ncbi_gene_id`). |
| | `gene_name` | text | Existing gene name. |
| | `association_description` | text | Biological context. It does not claim that a gene causes dietary deficiency. |
| | `source_url` | URL/text | NCBI Gene record URL constructed from the existing numeric identifier. |
| `protein_associations.csv` | `association_id` | integer | Existing `protein_associations.id`; preserve as the row key when importing this snapshot. |
| | `deficiency_id` | integer | Foreign-key value for `deficiency_master.deficiency_id`. |
| | `protein_name` | text | Protein label. |
| | `uniprot_accession` | text | Existing UniProt accession. |
| | `protein_function` | text | Brief biological function context. |
| | `association_description` | text | Explains the indirect iron-physiology relationship; not a diagnosis or causal claim. |
| | `source_url` | URL/text | UniProt accession URL. |
| `pathway_associations.csv` | `association_id` | integer | Existing `pathway_associations.id`; preserve as the row key when importing this snapshot. |
| | `deficiency_id` | integer | Foreign-key value for `deficiency_master.deficiency_id`. |
| | `pathway_name` | text | Existing local pathway label. |
| | `pathway_id` | text | Blank where a Reactome identifier could not be confidently verified; do not fill by guessing. |
| | `pathway_description` | text | Flags existing labels whose exact Reactome mapping remains unresolved. |
| | `source_url` | URL/text | Reactome entry point; it is not evidence that the local label has a specific Reactome ID. |
| `dataset_sources.csv` | `source_id` | integer | Primary key for a provenance record in the new `dataset_sources` table. |
| | `dataset_name` | text | Dataset or data group to which the source record relates. |
| | `organization` | text | Source organization or local project database. |
| | `source_url` | URL/text | Source or record entry-point URL; blank only when no web URL exists. |
| | `record_identifier` | text | Source record, collection, or scope identifier. |
| | `version_or_release` | text | Source release when known; otherwise `Unknown`. |
| | `access_date` | ISO date | Source inventory access date; values vary by source record. |
| | `license` | text | License/reuse statement, with caveats where source rights are mixed or unknown. |
| | `verification_status` | text | Records the verification performed and material limitations. |

## Primary keys and relationships

- `deficiency_master.csv`: primary key `deficiency_id`.
- `symptom_master.csv`: primary key `symptom_id`.
- `deficiency_symptoms.csv`: logical composite key `(deficiency_id, symptom_id)`; both columns reference their respective master IDs. The live database has its own auto-increment `id` and enforces the relationship constraints.
- `food_recommendations.csv`: logical candidate key `(deficiency_id, food_name)`; `deficiency_id` references the deficiency master. Confirm duplicate/case-colliding names before adding a unique constraint.
- `gene_associations.csv`, `protein_associations.csv`, `pathway_associations.csv`: primary key is the exported existing `association_id`; `deficiency_id` references the deficiency master.
- `dataset_sources.csv`: primary key `source_id`.

## Important limitations

The current database contains 48 symptom mappings with project-defined weights. This export preserves them for traceability; it does **not** assert that all are medically established. Several source pages could not be retrieved by the research tool, and the mapping file expressly marks pairwise support as unverified. The local gene, protein, pathway, and food records are also a snapshot, not a complete nutrient knowledge base. See `validation_report.md` before using the data.

The eight CSVs in `data/integrated/` contain 225 data rows: 20 deficiencies,
20 symptoms, 48 symptom relationships, 85 food recommendations, 5 genes,
5 proteins, 4 pathways, and 38 provenance records. The separate
`datasets/` folder contains 650 rows, including 500 food nutrient
measurements and 46 provenance records. Many master and association rows
appear in both folders, so these folder totals must not be interpreted as
unique-entity counts. Core association CSVs do not provide a consistent
per-record verification-status field. NIH ODS pages returned HTTP 403 in the
previous source check, UniProt records were not independently verified, and
all four Reactome IDs remain blank/unresolved. These records must remain
pending rather than being inferred from a source link alone.

The protein association export preserves the existing MySQL protein display
names. It uses `Ferritin Heavy Chain` for association 1 and
`Transferrin Receptor Protein 2` for association 3; no database protein
records were modified for this correction.

## Additional source-checked datasets in `datasets/`

The following additive datasets are stored outside this generated snapshot so
that rerunning `generate_datasets.php` does not replace them:

| File | Rows | Key fields and meaning |
|---|---:|---|
| `food_nutrient_data.csv` | 500 | `food_record_id` is the local row key; `fdc_id` is the official FoodData Central ID; nutrient amount/unit and the per-100-g record basis are kept from USDA; `source_url` targets the exact food record; `verification_status` records source checking. Includes 35 earlier measurements and 465 additional measurements from the Foundation Foods CSV release dated 2026-04-30; it is not a verified one-to-one match for the food recommendations. |
| `compound_data.csv` | 2 | `compound_id` is a local key; `pubchem_cid` is the official PubChem CID; formula, molecular weight, related nutrient, record URL, and verification status are provided for the source-checked PubChem records. |

The matching additive MySQL tables are `food_nutrient_data` and
`compound_data`, created by `datasets/scientific_datasets_migration.sql`.
`food_nutrient_data` is keyed by its local `food_record_id` and also enforces
uniqueness of `(fdc_id, nutrient_name)`. `compound_data` is keyed by
`compound_id` and enforces a unique PubChem CID. The import utility adds rows
only and preserves conflicts for manual review.

The 500 FoodData Central measurements cover 248 distinct food IDs and 14
nutrient names. They are composition data, not a complete match for every
existing food recommendation or nutrient deficiency. The 85 food
recommendation records remain the prior project dataset. The two PubChem
entries are nutrient compounds, not drug recommendations. The dataset
importer and validator completed successfully in this workspace: the CSV and
database each contain 500 food measurements. These are food-composition
records, not clinical findings or predictions.
