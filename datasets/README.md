# DefiMap datasets

These UTF-8 CSV files are a traceable export of the existing DefiMap nutrient
tables. Their IDs and current application records were matched to the live
database schema before import was attempted.

The CSV files currently contain 650 data rows in total:

| File | Rows |
| --- | ---: |
| `deficiency_master.csv` | 20 |
| `symptom_master.csv` | 20 |
| `deficiency_symptoms.csv` | 48 |
| `gene_associations.csv` | 5 |
| `protein_associations.csv` | 5 |
| `pathway_associations.csv` | 4 |
| `dataset_sources.csv` | 46 |
| `food_nutrient_data.csv` | 500 |
| `compound_data.csv` | 2 |

The existing 85 food recommendations are available in
`data/integrated/food_recommendations.csv`; there is no replacement
recommendation file at the root of `datasets/`. They remain unchanged in
MySQL and are not modified by either import utility.

## Import safely

The current database has the required metadata tables. Its legacy
`deficiency_symptoms` table lacked non-null relationship fields, pair
uniqueness, and foreign keys. The additive migration below was preflighted
against the live data (zero null fields, orphan references, or duplicate
pairs) and applied without changing its 48 relationship rows. It is a
one-time migration; do not rerun it after the constraints exist.

```powershell
Get-Content 'C:\xampp\htdocs\Defimap\datasets\001_add_symptom_relationship_constraints.sql' -Raw |
    & 'C:\xampp\mysql\bin\mysql.exe' -uroot --default-character-set=utf8mb4 defimap
& 'C:\xampp\php\php.exe' 'C:\xampp\htdocs\Defimap\datasets\import.php'
```

The importer is CLI-only and returns 404 if requested over HTTP. It uses PDO
prepared statements and a MySQL advisory lock, checks CSV headers, UTF-8,
URLs, parent IDs and existing records, and runs inserts in one transaction.
Matching records are skipped; conflicting records stop the import and roll
back. It never updates or deletes application records and does not import
food-recommendation rows. Since it is not exposed as a web endpoint, browser
sessions and CSRF tokens do not apply; access is limited to an operator who
can run local PHP CLI and use the configured database account.

## Evidence limitations

This is a snapshot of existing project data, not a newly curated biomedical
reference set. The project’s symptom weights are legacy heuristics and have
not been independently validated as deficiency associations. Gene and
protein entries describe nutrient-metabolism context and do not establish
that a gene or protein causes dietary deficiency. Pathway IDs remain blank
where no exact Reactome match was verified. NIH ODS links are supplied as
source leads; the existing collection report records that their pages were
not retrievable for claim-level verification during collection.

The Vitamin B12 description is blank because the application database has no
description for that record; the generated fallback description was removed
from this CSV rather than treated as source-verified information. Existing
database data has not been edited.

## Additional source-checked records

`food_nutrient_data.csv` contains 500 source-backed nutrient measurements:
the original 35 records plus 465 measurements extracted from the official
USDA FoodData Central Foundation Foods CSV release dated 2026-04-30. Each
record keeps its FDC food ID, nutrient name, unit, per-100-g basis, source
URL, and verification status. These composition measurements are not a
complete match set for all 85 existing food recommendations and do not
replace or validate those recommendation texts. The 500 measurements cover
248 distinct food IDs and 14 nutrient names.

`compound_data.csv` contains two PubChem records (ascorbic acid and thiamine)
with official CIDs, formulae, molecular weights, source URLs, and verification
status. `dataset_sources.csv` records the sources, including the USDA archive
release used for the additional measurements.

Apply the additive migration, then import provenance and scientific records:

```powershell
Get-Content 'C:\xampp\htdocs\DefiMap\datasets\scientific_datasets_migration.sql' -Raw |
    & 'C:\xampp\mysql\bin\mysql.exe' -uroot --default-character-set=utf8mb4 defimap
& 'C:\xampp\php\php.exe' 'C:\xampp\htdocs\DefiMap\datasets\import.php'
& 'C:\xampp\php\php.exe' 'C:\xampp\htdocs\DefiMap\datasets\import_scientific_datasets.php'
& 'C:\xampp\php\php.exe' 'C:\xampp\htdocs\DefiMap\datasets\validate_scientific_datasets.php'
```

Alternatively, after creating the tables, `food_nutrient_data_500.sql` can
insert the 500 food-composition rows. It is repeatable for matching records
and fails rather than overwriting a conflicting record. The PHP importer is
recommended because it also imports the source metadata and other scientific
CSV files.

The scientific importer is CLI-only, transactional, prepared-statement based,
and additive. Matching rows are skipped; conflicting records roll back. It
never updates or deletes existing rows. The results page displays matching
FoodData Central measurements and PubChem nutrient compounds with their
official identifiers and links. In this workspace, the importer added 465
measurements and matched the 35 existing rows; validation confirmed 500 CSV
rows and 500 database rows with no rejected or pending records.

## Remaining source verification

The NIH ODS fact sheets returned HTTP 403 during this run. The five existing
gene IDs, symbols, human organism, and NCBI record summaries were checked via
the NCBI Datasets API, but these iron-homeostasis roles do not establish that
the genes cause dietary iron deficiency. UniProt record verification was
blocked, and the four existing Reactome labels still have no exact verified
pathway IDs. The 20 symptom glosses, 48 legacy symptom mappings, and 85
recommendation texts remain pending claim-level source review. They must not
be represented as clinical predictions or verified advice.
