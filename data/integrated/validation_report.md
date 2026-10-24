# Dataset validation report

Generated from the live local MySQL database on 2026-10-18; updated on
2026-10-19 after read-only CSV/database comparison.

The previously approved additive staged imports are already present in this
local database. This update did not run an import, migration, or database
write.

## Structural checks

| Dataset | Rows | Primary/logical key check | Foreign-key check |
|---|---:|---|---|
| Deficiency master | 20 | 20 unique deficiency IDs | Not applicable |
| Symptom master | 20 | 20 unique symptom IDs | Not applicable |
| Deficiency-symptom mappings | 48 | No duplicate `(deficiency_id, symptom_id)` pairs found | All deficiency and symptom IDs resolve |
| Food recommendations | 85 | No duplicate `(deficiency_id, normalized food_name)` pairs found | All deficiency IDs resolve |
| Gene associations | 5 | 5 unique association IDs | All deficiency IDs resolve |
| Protein associations | 5 | 5 unique association IDs | All deficiency IDs resolve |
| Pathway associations | 4 | 4 unique association IDs | All deficiency IDs resolve |
| Dataset sources | 38 in the original integrated snapshot; 45 in the current `datasets/` file | 45 unique source IDs in the current root dataset | Not applicable |

All current food records have nonblank food names, benefits, and cautions. The deficiency names and IDs correspond to the existing database. The database currently has 20 symptom labels; symptom descriptions in this export are cautious editorial glosses, not quotations from a symptom-specific medical reference.

## Scientific/source review status

- The nutrient fact-sheet URL pattern follows NIH ODS conventions, but requests to ODS pages returned HTTP 403 in the research environment. Individual page availability, contents, and claim-level support therefore remain **unverified in this run**. Check each fact sheet manually before relying on the content.
- The local deficiency-symptom scores were exported unchanged. The weights are project-specific rules, have not been validated, and are not clinical probabilities. The `evidence_note` column explicitly warns that a nutrient fact sheet does not validate an individual symptom mapping.
- The 85 food recommendation records remain existing project text and are not all matched to USDA records. A separate additive dataset now contains 35 per-100-g nutrient measurements from five verified FoodData Central records; it does not validate every recommendation.
- Five existing NCBI gene identifiers, symbols, human organism, and record summaries were checked through NCBI Datasets. This verifies record identity and molecular context, not a causal relationship to dietary deficiency. UniProt records were not independently verified in this run.
- Reactome pathway IDs are blank because an exact name-to-ID match was not verified. Do not infer stable pathway IDs from generic labels.
- Release/version details are set to `Unknown` when not established. The source file records access date and license caveats rather than inventing values.

## Source and license inventory

- **USDA FoodData Central**: its official About page states that FDC data are public domain under CC0 1.0 and requests attribution. A separate additive dataset contains 35 source-checked nutrient measurements from five FDC records.
- **NCBI/NLM**: the official NCBI policy states that NCBI places no restrictions on molecular database data, while submitter and third-party rights may still apply. Gene record content should be checked for such notices.
- **Reactome**: its official license page says Reactome database data are CC0; pathway illustrations are CC BY 4.0; software and other materials can have different terms.
- **MedlinePlus/NLM**: U.S. government-created NLM content is public domain, with possible third-party copyright exceptions. The symptom CSV uses a general entry point, not copied article text.
- **NIH Office of Dietary Supplements**: no page-specific license determination was made; the inventory marks this as unknown and calls for review of notices and third-party content.
- **UniProt**: no license assertion is made in this export; verify the current UniProtKB license and attribution terms before redistribution.
- **Local DefiMap data**: the project owner has not specified a reuse license.

## Known schema mismatches

The requested CSVs contain provenance and explanatory fields absent from the live MySQL tables:

| Current table | Existing fields usable | Requested fields not currently present |
|---|---|---|
| `deficiency_master` | `deficiency_id`, `deficiency_name`, `description` | `related_nutrient`, `source_url` |
| `symptom_master` | `symptom_id`, `symptom_name` | `description`, `source_url` |
| `deficiency_symptoms` | `id`, `deficiency_id`, `symptom_id`, `weight` | `evidence_note`, `source_url` are in companion metadata |
| `food_recommendations` | `deficiency_id`, `food_name`, `benefits`, `avoid_food` | `nutrient_name`, `source_url`; `benefit` maps to `benefits`, `caution` maps to `avoid_food` |
| `gene_associations` | `id`, `deficiency_id`, `gene_symbol`, `gene_name`, `ncbi_gene_id` | `association_description`, `source_url`; `association_id` maps to `id`, `gene_id` maps to `ncbi_gene_id` |
| `protein_associations` | `id`, `deficiency_id`, `protein_name`, `uniprot_accession` | `protein_function`, `association_description`, `source_url`; `association_id` maps to `id` |
| `pathway_associations` | `id`, `deficiency_id`, `pathway_name` | `pathway_id`, `pathway_description`, `source_url`; `association_id` maps to `id` |
| `dataset_sources` | `source_id` and provenance fields | No further application-facing scientific assertions |

`schema_and_import.sql` creates additive staging and metadata tables without
dropping or overwriting the application's live data tables. The inspected
live schema has 17 foreign-key constraints.

## Source-checked additions and current database validation (2026-10-19)

The current local `defimap` database was inspected read-only. The actual
application counts were 20 deficiencies, 20
symptoms, 48 deficiency-symptom mappings, 85 food recommendations, 5 genes,
5 proteins, 4 pathways, 2 users, and 16 analyses. Additional current counts
are 45 source records, 35 USDA food-nutrient measurements, and 2 PubChem
compounds. This audit made no database changes. Historical import results
are described separately below.

| New CSV | Data rows | Verified | Partially verified | Pending | Rejected | Imported |
|---|---:|---:|---:|---:|---:|---:|
| `datasets/food_nutrient_data.csv` | 35 | 35 | 0 | 0 | 0 | 35 inserted |
| `datasets/compound_data.csv` | 2 | 2 | 0 | 0 | 0 | 2 inserted |
| Added `dataset_sources.csv` records | 7 | 7 source records | 0 | 0 | 0 | 7 inserted |

The source checks performed directly in this run were:

- **USDA FoodData Central:** five real Foundation IDs (`1999632`, `2258590`,
  `2684441`, `2515380`, `2515381`), with 35 nutrient amounts, units, food
  names, and per-100-g basis recorded. The values were retrieved from the
  official FDC API on 2026-10-19. Only these 35 food-nutrient rows are
  source-checked; the 85 existing recommendations are not individually
  matched to FDC.
- **PubChem:** CID `54670067` (ascorbic acid; `C6H8O6`; 176.12 g/mol) and CID
  `1130` (thiamine; `C12H17N4OS+`; 265.36 g/mol) were returned by the official
  PUG REST property endpoint on 2026-10-19.
- **NCBI Gene:** all five existing iron-related IDs and symbols were checked
  using the official NCBI Datasets API: HAMP/57817, HFE/3077,
  SLC40A1/30061, TF/7018, and TFR2/7036. They are human genes with roles in
  iron homeostasis or transport. Nutritional deficiency causation is not
  established by these records.
- **NIH ODS:** direct requests returned HTTP 403. The 20 deficiency entries,
  20 editorial symptom descriptions, 48 symptom mappings, and 85
  recommendation text records therefore remain pending claim-level review.
- **UniProt and Reactome:** primary UniProt record verification was blocked.
  The four Reactome labels retain blank IDs because no exact ID was confirmed.
  All five protein records and four pathway-ID mappings remain pending.

Across the 224 substantive rows in the current datasets (20 deficiency, 20
symptom, 48 relationship, 85 recommendation, 5 gene, 5 protein, 4 pathway,
35 food-composition, and 2 compound records), the evidence classification is
37 verified source-data rows, 5 partially verified gene-context rows, 182
pending rows, and 0 rejected rows. "Verified" describes the source record and
the listed values only; it does not mean a clinical recommendation or
deficiency association is validated.

The seven requested root CSVs contain 147 rows: 20 deficiencies, 20
symptoms, 48 relationships, 5 genes, 5 proteins, 4 pathways, and 45 source
records. The recommendation snapshot adds 85, and the USDA and PubChem
datasets add 35 and 2, for 269 CSV data rows including provenance rows.
All CSVs parsed with the expected columns and row widths. No duplicate
identifiers/logical keys, invalid nonblank URLs, or invalid deficiency or
symptom references were found. Expected blanks include a Vitamin B12
description, four unresolved Reactome IDs, and two local-only source URLs.
Core CSVs do not consistently encode a per-record verification status.

The read-only comparison found matching database values for deficiencies
(20), symptoms (20), mappings (48), genes (5), pathways (4), recommendation
records (85), sources (45), USDA measurements (35), and compounds (2).
Protein association IDs and accessions matched; two CSV protein display
names differed before this correction. The exporter now preserves the exact
MySQL display names: association 1 `Ferritin Heavy Chain`, association 3
`Transferrin Receptor Protein 2`. The CSV labels are corrected; MySQL was not
changed.

Historically, the import utility reported 7 provenance rows inserted, and the
scientific importer reported 35 food measurements plus 2 compounds inserted,
0 updated, and 0 rejected; its idempotent rerun skipped all 37 records. No
dataset import was run for these code changes. Temporary test-only user and
analysis records were inserted for the HTTP flow test and then removed. The
existing 85 food recommendations, 35 USDA measurements, and 2 compounds
remain present.

Validation performed for the dataset-display changes and the later analysis
submission fix:

- PHP 8.2 syntax checks passed for `generate_datasets.php`, `tools.php`,
  `analysis.php`, and `results.php`.
- `data/integrated/validate_datasets.php` passed: expected CSV structures and
  counts, unique keys, references, and source URL checks; two local-only
  provenance records correctly have blank source URLs.
- `datasets/validate_scientific_datasets.php` passed: 35/35 USDA rows and
  2/2 compound rows match the database; all seven existing application
  dataset counts remained at their expected baselines, and there were zero
  orphan symptom mappings.
- A direct read-only comparison of all five protein CSV association IDs and
  names against MySQL reported zero mismatches. Association 1 is
  `Ferritin Heavy Chain`; association 3 is
  `Transferrin Receptor Protein 2`.
- Apache was started; `http://localhost/` returned HTTP 200 and the DefiMap
  landing page rendered at `http://localhost/defimap/`. MySQL was already
  listening on port 3306. A direct request to `tools.php` redirected to the
  login page because the shared browser session is unauthenticated.
- The analysis form was tested through Apache HTTP requests with a temporary
  authenticated test account. A POST without the submit button's name now
  correctly redirects to the results report and renders ranked associations.
  A symptom with no mapping renders a clear no-match report rather than
  failing. The temporary account and its analysis rows were removed after
  the test; final counts returned to 2 users and 16 analyses. This was an
  HTTP flow test, not a manual click-through in the shared browser.
- Authenticated Nutrition/Molecular Explorer rendering, history, and report
  navigation were not tested.

### Remaining manual work

Retrieve/review the NIH ODS and UniProt entries where access permits; verify
each symptom mapping and each recommendation claim against claim-specific
sources; obtain exact Reactome mappings; match all existing recommendation
foods to appropriate FDC foods without substituting near matches; and review
source licensing notices. The current base CSVs for deficiencies, symptoms,
symptom relationships, genes, proteins, and pathways still do not carry all
requested per-record fields such as verification status, organism, or
evidence strength. Those records were not overwritten or falsely promoted to
verified status.
