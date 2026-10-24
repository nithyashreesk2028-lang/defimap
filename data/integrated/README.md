# DefiMap integrated data pack

This folder contains a CSV snapshot of the existing DefiMap MySQL tables plus explanatory metadata columns, an additive import plan, a data dictionary, and a validation report.

## Files

- `deficiency_master.csv`
- `symptom_master.csv`
- `deficiency_symptoms.csv`
- `food_recommendations.csv`
- `gene_associations.csv`
- `protein_associations.csv`
- `pathway_associations.csv`
- `dataset_sources.csv`
- `data_dictionary.md`
- `validation_report.md`
- `schema_and_import.sql`
- `validation.sql`
- `generate_datasets.php` — regenerates all CSVs from the configured local `defimap` MySQL database.
- `validate_datasets.php` — checks CSV headers, field counts, duplicate keys, foreign-key references, source URL presence, and row counts against the live database.
- `load_datasets_to_stage.php` — CLI-only loader for the eight CSVs into the additive `stage_*` tables. Each run replaces only staging rows, not live application data.

## Generate and validate on XAMPP

From PowerShell:

```powershell
& 'C:\xampp\php\php.exe' 'C:\xampp\htdocs\defimap\data\integrated\generate_datasets.php'
& 'C:\xampp\php\php.exe' 'C:\xampp\htdocs\defimap\data\integrated\validate_datasets.php'
```

The generator is CLI-only and exports only the nutrient reference tables; it does not export user accounts or analysis records.

## Import guidance

Read `validation_report.md` and `schema_and_import.sql` before importing. The CSVs are enriched beyond the current application tables.

1. Back up the database.
2. Run only the initial `CREATE TABLE` section of `schema_and_import.sql` to add the staging and metadata tables.
3. Run `load_datasets_to_stage.php` from PHP CLI.
4. Run `validation.sql`; resolve any ID conflicts or invalid references before continuing.
5. Run the merge section of `schema_and_import.sql` to add missing rows and metadata.

The merge is repeatable: it inserts only missing master, mapping, food, and association rows, preserves existing food benefits/cautions and symptom weights, and updates companion metadata. In the current DefiMap database, this import has completed; the validation report records the outcome. The application’s PHP pages continue using the original tables.

The PHP pages continue to use the existing tables and need no changes to keep working. The new companion tables preserve dataset provenance without altering those page-facing schemas; to display citations in reports or explorer pages, update the relevant PHP queries to join the companion metadata tables.

Import parent/master datasets before association datasets. Use phpMyAdmin's CSV importer with the first row treated as column names, or enable MySQL `LOCAL INFILE` before using the optional example in the SQL file. Back up the database before any production import.

## Interpretation and licensing

The current application's weighted symptom mappings are not validated diagnostics. Nutrient fact-sheet URLs are supplied as research starting points; the NIH ODS pages returned HTTP 403 in the collection environment, so the report does not claim they were content-verified. The existing pathway labels have no asserted Reactome IDs. See `dataset_sources.csv` for recorded license caveats and verification states.
