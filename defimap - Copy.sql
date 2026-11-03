-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 01, 2026 at 07:05 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `defimap`
--

-- --------------------------------------------------------

--
-- Table structure for table `analyses`
--

CREATE TABLE `analyses` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `deficiency` varchar(100) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `symptoms` text DEFAULT NULL,
  `diet` text DEFAULT NULL,
  `family_history` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `notes` text DEFAULT NULL,
  `water_intake` varchar(50) DEFAULT NULL,
  `exercise` varchar(50) DEFAULT NULL,
  `sleep_hours` varchar(50) DEFAULT NULL,
  `stress_level` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `analyses`
--

INSERT INTO `analyses` (`id`, `user_id`, `deficiency`, `score`, `symptoms`, `diet`, `family_history`, `created_at`, `notes`, `water_intake`, `exercise`, `sleep_hours`, `stress_level`) VALUES
(1, 1, '', 0, 'Dry Skin, Hair Loss, Loss of Appetite, Muscle Cramps', 'Vegetarian', '', '2026-10-04 14:40:03', '', '1-2 Liters', '1-2 Days / Week', '5-7 Hours', 'Moderate'),
(2, 1, '', 0, 'Dry Skin, Hair Loss, Loss of Appetite, Muscle Cramps', 'Vegetarian', '', '2026-10-04 14:41:14', '', '1-2 Liters', '1-2 Days / Week', '5-7 Hours', 'Moderate'),
(3, 1, 'Biotin Deficiency', 8, 'Dry Skin, Hair Loss, Loss of Appetite, Muscle Cramps', 'Vegetarian', '', '2026-10-04 15:03:07', '', '1-2 Liters', '1-2 Days / Week', '5-7 Hours', 'Moderate'),
(4, 1, 'Biotin Deficiency', 8, 'Dry Skin, Hair Loss, Loss of Appetite, Muscle Cramps', 'Vegetarian', '', '2026-10-04 15:03:11', '', '1-2 Liters', '1-2 Days / Week', '5-7 Hours', 'Moderate'),
(5, 1, 'Vitamin C Deficiency', 8, 'Numbness, Poor Wound Healing, Weakness', 'Vegetarian', '', '2026-10-04 15:04:20', '', '1-2 Liters', '1-2 Days / Week', 'Less than 5 Hours', 'Moderate'),
(6, 1, 'Iron Deficiency', 5, 'Bleeding Gums, Brittle Nails, Dizziness, Fatigue', 'Vegan', '', '2026-10-04 15:41:40', '', '2-3 Liters', '1-2 Days / Week', '7-9 Hours', 'High'),
(7, 1, 'Biotin Deficiency', 5, 'Hair Loss, Loss of Appetite', 'Non Vegetarian', '', '2026-10-04 15:43:28', '', '1-2 Liters', '1-2 Days / Week', 'Less than 5 Hours', 'High'),
(8, 1, 'Selenium Deficiency', 6, 'Bleeding Gums, Dizziness, Fatigue, Hair Loss, Loss of Appetite', 'Non Vegetarian', 'Vitamin D Deficiency', '2026-10-04 15:45:41', '', '1-2 Liters', '1-2 Days / Week', 'Less than 5 Hours', 'High'),
(9, 1, 'Biotin Deficiency', 5, 'Hair Loss', 'Balanced Diet', '', '2026-10-04 15:46:21', '', '1-2 Liters', 'Daily', 'More than 9 Hours', ''),
(10, 1, '', 0, '', 'Balanced Diet', '', '2026-10-04 15:46:41', '', '1-2 Liters', 'Daily', 'More than 9 Hours', ''),
(11, 1, 'Vitamin B12 Deficiency', 5, 'Bleeding Gums, Brittle Nails, Dizziness', 'Balanced Diet', '', '2026-10-04 15:46:54', '', '1-2 Liters', 'Daily', 'More than 9 Hours', ''),
(12, 1, 'Biotin Deficiency', 5, 'Hair Loss', 'Balanced Diet', '', '2026-10-04 15:48:17', '', '1-2 Liters', 'Daily', 'More than 9 Hours', ''),
(13, 2, 'Vitamin B12 Deficiency', 5, 'Bleeding Gums', '', '', '2026-10-10 14:10:42', '', '', '', '', ''),
(14, 2, 'Iron Deficiency', 10, 'Bleeding Gums, Fatigue, Pale Skin, Poor Wound Healing', 'Balanced Diet', '', '2026-10-10 14:12:40', '', '2-3 Liters', 'Daily', 'More than 9 Hours', 'High'),
(15, 2, 'Iron Deficiency', 15, 'Dizziness, Fatigue, Numbness, Pale Skin, Shortness of Breath', 'Non Vegetarian', '', '2026-10-10 14:14:47', '', '2-3 Liters', 'Never', '7-9 Hours', 'Moderate'),
(16, 2, 'Iron Deficiency', 8, 'Dizziness, Fatigue, Hair Loss, Headache', 'Non Vegetarian', '', '2026-10-17 12:43:47', '', '1-2 Liters', '', '7-9 Hours', ''),
(23, 2, 'Calcium Deficiency', 5, 'Bone Pain, Dizziness, Depression, Headache', '', '', '2026-10-19 10:01:02', '', '', '', '', 'Low'),
(24, 2, 'Folate Deficiency', 5, 'Pale Skin, Muscle Cramps, Dry Skin, Frequent Infections', '', '', '2026-10-19 10:03:03', '', '', '', '', 'Low'),
(25, 2, 'Calcium Deficiency', 5, 'Bone Pain, Bleeding Gums, Dizziness, Brittle Nails, Headache', '', '', '2026-10-19 10:12:53', '', '', '', '', 'Low'),
(26, 2, 'Biotin Deficiency', 5, 'Hair Loss, Depression, Headache', '', '', '2026-10-19 10:41:14', '', '', '', '', 'Low'),
(27, 2, 'Biotin Deficiency', 5, 'Hair Loss, Bleeding Gums, Headache', '', '', '2026-10-19 14:53:27', '', '', '', '', 'Low'),
(28, 2, 'Calcium Deficiency', 5, 'Bone Pain, Brittle Nails, Headache', '', '', '2026-10-24 15:15:12', '', '', '', '', 'Low'),
(29, 2, 'Biotin Deficiency', 5, 'Hair Loss, Bleeding Gums, Dizziness', '', '', '2026-10-24 15:18:00', '', '', '', '', 'Low'),
(30, 2, 'Biotin Deficiency', 5, 'Hair Loss, Bone Pain, Mouth Ulcers, Dizziness, Weight Loss', '', '', '2026-10-24 16:42:30', '', '', '', '', 'Low'),
(31, 2, 'Biotin Deficiency', 9, 'Hair Loss, Bleeding Gums, Brittle Nails', '', '', '2026-10-24 16:54:22', '', '', '', '', 'Low');

-- --------------------------------------------------------

--
-- Table structure for table `compound_data`
--

CREATE TABLE `compound_data` (
  `compound_id` int(11) NOT NULL,
  `pubchem_cid` bigint(20) NOT NULL,
  `compound_name` varchar(255) NOT NULL,
  `molecular_formula` varchar(100) NOT NULL,
  `molecular_weight` decimal(18,8) NOT NULL,
  `related_nutrient` varchar(100) NOT NULL,
  `source_url` varchar(2048) NOT NULL,
  `verification_status` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `compound_data`
--

INSERT INTO `compound_data` (`compound_id`, `pubchem_cid`, `compound_name`, `molecular_formula`, `molecular_weight`, `related_nutrient`, `source_url`, `verification_status`) VALUES
(1, 54670067, 'Ascorbic acid', 'C6H8O6', 176.12000000, 'Vitamin C', 'https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/name/ascorbic%20acid/property/MolecularFormula,MolecularWeight/JSON', 'verified'),
(2, 1130, 'Thiamine', 'C12H17N4OS+', 265.36000000, 'Vitamin B1 (thiamin)', 'https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/name/thiamine/property/MolecularFormula,MolecularWeight/JSON', 'verified');

-- --------------------------------------------------------

--
-- Table structure for table `dataset_sources`
--

CREATE TABLE `dataset_sources` (
  `source_id` int(11) NOT NULL,
  `dataset_name` varchar(255) NOT NULL,
  `organization` varchar(255) NOT NULL,
  `source_url` varchar(2048) NOT NULL,
  `record_identifier` varchar(255) NOT NULL,
  `version_or_release` varchar(100) NOT NULL,
  `access_date` date NOT NULL,
  `license` text NOT NULL,
  `verification_status` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dataset_sources`
--

INSERT INTO `dataset_sources` (`source_id`, `dataset_name`, `organization`, `source_url`, `record_identifier`, `version_or_release`, `access_date`, `license`, `verification_status`) VALUES
(1, 'Deficiency, symptom, and association masters', 'DefiMap local project database', '', 'Current live rows in deficiency_master, symptom_master, and deficiency_symptoms', 'Unknown', '2026-10-18', 'Unknown; project reuse terms not supplied', 'Exported from local schema; scientific source verification remains incomplete.'),
(2, 'Food recommendations', 'DefiMap local project database', '', 'Current live food_recommendations rows', 'Unknown', '2026-10-18', 'Unknown; project reuse terms not supplied', 'Exported without overwriting records; food descriptions need claim-level review.'),
(3, 'Food composition reference', 'USDA Agricultural Research Service, FoodData Central', 'https://fdc.nal.usda.gov/', 'No FoodData Central record IDs or nutrient quantities imported', 'Unknown', '2026-10-18', 'CC0 1.0 Universal; USDA requests attribution', 'Official licensing page states USDA FDC data are public domain and CC0; no composition values or serving sizes are asserted in these CSVs.'),
(4, 'Symptom terminology', 'U.S. National Library of Medicine, MedlinePlus', 'https://medlineplus.gov/symptoms.html', 'General symptoms information page', 'Unknown', '2026-10-18', 'U.S. government-created NLM content is public domain; third-party content may have separate restrictions', 'Official MedlinePlus symptoms entry point recorded; individual symptom definitions are cautious project glosses, not copied clinical text.'),
(5, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/', 'Iron-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(6, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/VitaminD-HealthProfessional/', 'VitaminD-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(7, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/VitaminB12-HealthProfessional/', 'VitaminB12-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(8, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/VitaminA-HealthProfessional/', 'VitaminA-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(9, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/VitaminC-HealthProfessional/', 'VitaminC-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(10, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/VitaminE-HealthProfessional/', 'VitaminE-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(11, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/VitaminK-HealthProfessional/', 'VitaminK-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(12, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/Thiamin-HealthProfessional/', 'Thiamin-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(13, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/Riboflavin-HealthProfessional/', 'Riboflavin-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(14, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/Niacin-HealthProfessional/', 'Niacin-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(15, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/VitaminB6-HealthProfessional/', 'VitaminB6-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(16, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/Biotin-HealthProfessional/', 'Biotin-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(17, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/Folate-HealthProfessional/', 'Folate-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(18, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/Calcium-HealthProfessional/', 'Calcium-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(19, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/Magnesium-HealthProfessional/', 'Magnesium-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(20, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/Zinc-HealthProfessional/', 'Zinc-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(21, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/Copper-HealthProfessional/', 'Copper-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(22, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/Iodine-HealthProfessional/', 'Iodine-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(23, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/Selenium-HealthProfessional/', 'Selenium-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(24, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/Potassium-HealthProfessional/', 'Potassium-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(25, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/57817', 'NCBI Gene 57817', 'Unknown', '2026-10-18', 'NCBI places no restrictions on molecular database data; submitter and third-party rights may still apply', 'Identifier and record URL are retained from the current project data; verify the live NCBI record and any submitter notices before reuse.'),
(26, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/3077', 'NCBI Gene 3077', 'Unknown', '2026-10-18', 'NCBI places no restrictions on molecular database data; submitter and third-party rights may still apply', 'Identifier and record URL are retained from the current project data; verify the live NCBI record and any submitter notices before reuse.'),
(27, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/30061', 'NCBI Gene 30061', 'Unknown', '2026-10-18', 'NCBI places no restrictions on molecular database data; submitter and third-party rights may still apply', 'Identifier and record URL are retained from the current project data; verify the live NCBI record and any submitter notices before reuse.'),
(28, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/7018', 'NCBI Gene 7018', 'Unknown', '2026-10-18', 'NCBI places no restrictions on molecular database data; submitter and third-party rights may still apply', 'Identifier and record URL are retained from the current project data; verify the live NCBI record and any submitter notices before reuse.'),
(29, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/7036', 'NCBI Gene 7036', 'Unknown', '2026-10-18', 'NCBI places no restrictions on molecular database data; submitter and third-party rights may still apply', 'Identifier and record URL are retained from the current project data; verify the live NCBI record and any submitter notices before reuse.'),
(30, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P02794', 'UniProt accession P02794', 'Unknown', '2026-10-18', 'Unknown; verify current UniProtKB license and attribution terms before redistribution', 'Accession and record URL are retained from the current project data; confirm the live UniProt record and current license before reuse.'),
(31, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q9NP59', 'UniProt accession Q9NP59', 'Unknown', '2026-10-18', 'Unknown; verify current UniProtKB license and attribution terms before redistribution', 'Accession and record URL are retained from the current project data; confirm the live UniProt record and current license before reuse.'),
(32, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P81172', 'UniProt accession P81172', 'Unknown', '2026-10-18', 'Unknown; verify current UniProtKB license and attribution terms before redistribution', 'Accession and record URL are retained from the current project data; confirm the live UniProt record and current license before reuse.'),
(33, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P02787', 'UniProt accession P02787', 'Unknown', '2026-10-18', 'Unknown; verify current UniProtKB license and attribution terms before redistribution', 'Accession and record URL are retained from the current project data; confirm the live UniProt record and current license before reuse.'),
(34, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q9UP52', 'UniProt accession Q9UP52', 'Unknown', '2026-10-18', 'Unknown; verify current UniProtKB license and attribution terms before redistribution', 'Accession and record URL are retained from the current project data; confirm the live UniProt record and current license before reuse.'),
(35, 'Biological pathway associations', 'Reactome', 'https://reactome.org/content/detail/R-HSA-917937', 'R-HSA-917937', 'Reactome pathway stable ID', '2026-10-24', 'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms', 'Exact Homo sapiens pathway name and stable identifier verified against Reactome ContentService on 2026-10-24.'),
(36, 'Biological pathway associations', 'Reactome', '', 'Existing local label: Erythropoiesis', 'Unknown', '2026-10-18', 'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms', 'Legacy label retained for traceability; no exact Reactome pathway identifier has been verified.'),
(37, 'Biological pathway associations', 'Reactome', '', 'Existing local label: HIF-1 Signaling Pathway', 'Unknown', '2026-10-18', 'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms', 'Legacy label retained for traceability; no exact Reactome pathway identifier has been verified.'),
(38, 'Biological pathway associations', 'Reactome', '', 'Existing local label: Iron Homeostasis', 'Unknown', '2026-10-18', 'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms', 'Legacy label retained for traceability; no exact Reactome pathway identifier has been verified.'),
(39, 'Food nutrient composition', 'USDA Agricultural Research Service, FoodData Central', 'https://fdc.nal.usda.gov/food-details/1999632/nutrients', 'FDC 1999632; Spinach, baby', 'Unknown', '2026-10-19', 'CC0 1.0 Universal; USDA requests attribution', 'Official FDC API record and listed nutrient amounts retrieved and checked on 2026-10-19; Foundation values are per 100 g.'),
(40, 'Food nutrient composition', 'USDA Agricultural Research Service, FoodData Central', 'https://fdc.nal.usda.gov/food-details/2258590/nutrients', 'FDC 2258590; Peppers, bell, red, raw', 'Unknown', '2026-10-19', 'CC0 1.0 Universal; USDA requests attribution', 'Official FDC search response and listed nutrient amounts checked on 2026-10-19; Foundation values are per 100 g.'),
(41, 'Food nutrient composition', 'USDA Agricultural Research Service, FoodData Central', 'https://fdc.nal.usda.gov/food-details/2684441/nutrients', 'FDC 2684441; Fish, salmon, Atlantic, farm raised, raw', 'Unknown', '2026-10-19', 'CC0 1.0 Universal; USDA requests attribution', 'Official FDC search response and listed nutrient amounts checked on 2026-10-19; Foundation values are per 100 g.'),
(42, 'Food nutrient composition', 'USDA Agricultural Research Service, FoodData Central', 'https://fdc.nal.usda.gov/food-details/2515380/nutrients', 'FDC 2515380; Seeds, pumpkin seeds (pepitas), raw', 'Unknown', '2026-10-19', 'CC0 1.0 Universal; USDA requests attribution', 'Official FDC search response and listed nutrient amounts checked on 2026-10-19; Foundation values are per 100 g.'),
(43, 'Food nutrient composition', 'USDA Agricultural Research Service, FoodData Central', 'https://fdc.nal.usda.gov/food-details/2515381/nutrients', 'FDC 2515381; Seeds, sunflower seed, kernel, raw', 'Unknown', '2026-10-19', 'CC0 1.0 Universal; USDA requests attribution', 'Official FDC search response and listed nutrient amounts checked on 2026-10-19; Foundation values are per 100 g.'),
(44, 'Compound data', 'PubChem, National Center for Biotechnology Information', 'https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/name/ascorbic%20acid/property/MolecularFormula,MolecularWeight/JSON', 'PubChem CID 54670067; ascorbic acid', 'Unknown', '2026-10-19', 'Unknown; PubChem reuse terms not independently checked in this run', 'Official PubChem PUG REST response returned CID, molecular formula, and molecular weight on 2026-10-19.'),
(45, 'Compound data', 'PubChem, National Center for Biotechnology Information', 'https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/name/thiamine/property/MolecularFormula,MolecularWeight/JSON', 'PubChem CID 1130; thiamine', 'Unknown', '2026-10-19', 'Unknown; PubChem reuse terms not independently checked in this run', 'Official PubChem PUG REST response returned CID, molecular formula, and molecular weight on 2026-10-19.'),
(46, 'Food nutrient composition', 'USDA Agricultural Research Service, FoodData Central', 'https://fdc.nal.usda.gov/download-datasets/', 'FoodData Central Foundation Foods CSV release 2026-04-30; 465 additional food/nutrient measurements', '2026-04-30', '2026-10-24', 'CC0 1.0 Universal; USDA requests attribution', 'Extracted from official Foundation Foods CSV archive; measurements are per 100 g and each row links to its FDC food record.'),
(47, 'Pathway literature citations', 'PubMed / U.S. National Library of Medicine', 'https://pubmed.ncbi.nlm.nih.gov/11001804/', 'PMID:11001804', 'Unknown', '2026-10-24', 'Bibliographic citation metadata; article text and reuse rights are governed by the publisher or article license.', 'Citation title and PMID are listed by the linked Reactome pathway record; full article content was not reviewed.'),
(48, 'Pathway literature citations', 'PubMed / U.S. National Library of Medicine', 'https://pubmed.ncbi.nlm.nih.gov/18259769/', 'PMID:18259769', 'Unknown', '2026-10-24', 'Bibliographic citation metadata; article text and reuse rights are governed by the publisher or article license.', 'Citation title and PMID are listed by the linked Reactome pathway record; full article content was not reviewed.'),
(49, 'Pathway literature citations', 'PubMed / U.S. National Library of Medicine', 'https://pubmed.ncbi.nlm.nih.gov/19381358/', 'PMID:19381358', 'Unknown', '2026-10-24', 'Bibliographic citation metadata; article text and reuse rights are governed by the publisher or article license.', 'Citation title and PMID are listed by the linked Reactome pathway record; full article content was not reviewed.'),
(50, 'Pathway literature citations', 'PubMed / U.S. National Library of Medicine', 'https://pubmed.ncbi.nlm.nih.gov/20495089/', 'PMID:20495089', 'Unknown', '2026-10-24', 'Bibliographic citation metadata; article text and reuse rights are governed by the publisher or article license.', 'Citation title and PMID are listed by the linked Reactome pathway record; full article content was not reviewed.'),
(51, 'Pathway literature citations', 'PubMed / U.S. National Library of Medicine', 'https://pubmed.ncbi.nlm.nih.gov/21114891/', 'PMID:21114891', 'Unknown', '2026-10-24', 'Bibliographic citation metadata; article text and reuse rights are governed by the publisher or article license.', 'Citation title and PMID are listed by the linked Reactome pathway record; full article content was not reviewed.'),
(52, 'Pathway literature citations', 'PubMed / U.S. National Library of Medicine', 'https://pubmed.ncbi.nlm.nih.gov/22547309/', 'PMID:22547309', 'Unknown', '2026-10-24', 'Bibliographic citation metadata; article text and reuse rights are governed by the publisher or article license.', 'Citation title and PMID are listed by the linked Reactome pathway record; full article content was not reviewed.'),
(53, 'Pathway literature citations', 'PubMed / U.S. National Library of Medicine', 'https://pubmed.ncbi.nlm.nih.gov/26681795/', 'PMID:26681795', 'Unknown', '2026-10-24', 'Bibliographic citation metadata; article text and reuse rights are governed by the publisher or article license.', 'Citation title and PMID are listed by the linked Reactome pathway record; full article content was not reviewed.'),
(54, 'Pathway literature citations', 'PubMed / U.S. National Library of Medicine', 'https://pubmed.ncbi.nlm.nih.gov/26981194/', 'PMID:26981194', 'Unknown', '2026-10-24', 'Bibliographic citation metadata; article text and reuse rights are governed by the publisher or article license.', 'Citation title and PMID are listed by the linked Reactome pathway record; full article content was not reviewed.'),
(55, 'Pathway literature citations', 'PubMed / U.S. National Library of Medicine', 'https://pubmed.ncbi.nlm.nih.gov/33797888/', 'PMID:33797888', 'Unknown', '2026-10-24', 'Bibliographic citation metadata; article text and reuse rights are governed by the publisher or article license.', 'Citation title and PMID are listed by the linked Reactome pathway record; full article content was not reviewed.'),
(56, 'Pathway literature citations', 'PubMed / U.S. National Library of Medicine', 'https://pubmed.ncbi.nlm.nih.gov/9845520/', 'PMID:9845520', 'Unknown', '2026-10-24', 'Bibliographic citation metadata; article text and reuse rights are governed by the publisher or article license.', 'Citation title and PMID are listed by the linked Reactome pathway record; full article content was not reviewed.'),
(57, 'Biological pathway associations', 'Reactome', 'https://reactome.org/content/detail/R-HSA-196741', 'R-HSA-196741', 'Reactome pathway stable ID', '2026-10-24', 'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms', 'Exact Homo sapiens pathway name and stable identifier verified against Reactome ContentService on 2026-10-24.'),
(58, 'Biological pathway associations', 'Reactome', 'https://reactome.org/content/detail/R-HSA-196757', 'R-HSA-196757', 'Reactome pathway stable ID', '2026-10-24', 'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms', 'Exact Homo sapiens pathway name and stable identifier verified against Reactome ContentService on 2026-10-24.'),
(59, 'Biological pathway associations', 'Reactome', 'https://reactome.org/content/detail/R-HSA-196791', 'R-HSA-196791', 'Reactome pathway stable ID', '2026-10-24', 'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms', 'Exact Homo sapiens pathway name and stable identifier verified against Reactome ContentService on 2026-10-24.'),
(60, 'Biological pathway associations', 'Reactome', 'https://reactome.org/content/detail/R-HSA-6806664', 'R-HSA-6806664', 'Reactome pathway stable ID', '2026-10-24', 'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms', 'Exact Homo sapiens pathway name and stable identifier verified against Reactome ContentService on 2026-10-24.'),
(61, 'Biological pathway associations', 'Reactome', 'https://reactome.org/content/detail/R-HSA-8877627', 'R-HSA-8877627', 'Reactome pathway stable ID', '2026-10-24', 'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms', 'Exact Homo sapiens pathway name and stable identifier verified against Reactome ContentService on 2026-10-24.'),
(62, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/10560', 'NCBI Gene 10560', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(63, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/11212', 'NCBI Gene 11212', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(64, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/1317', 'NCBI Gene 1317', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(65, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/1356', 'NCBI Gene 1356', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(66, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/140803', 'NCBI Gene 140803', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(67, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/1591', 'NCBI Gene 1591', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(68, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/1594', 'NCBI Gene 1594', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(69, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/1719', 'NCBI Gene 1719', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(70, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/23475', 'NCBI Gene 23475', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(71, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/249', 'NCBI Gene 249', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(72, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/254428', 'NCBI Gene 254428', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(73, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/25974', 'NCBI Gene 25974', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(74, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/2638', 'NCBI Gene 2638', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(75, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/2677', 'NCBI Gene 2677', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(76, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/2694', 'NCBI Gene 2694', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(77, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/27010', 'NCBI Gene 27010', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(78, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/2876', 'NCBI Gene 2876', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(81, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/3141', 'NCBI Gene 3141', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(82, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/338', 'NCBI Gene 338', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(83, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/3758', 'NCBI Gene 3758', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(84, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/389434', 'NCBI Gene 389434', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(85, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/4524', 'NCBI Gene 4524', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(86, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/476', 'NCBI Gene 476', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(87, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/486', 'NCBI Gene 486', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(88, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/51091', 'NCBI Gene 51091', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(89, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/53630', 'NCBI Gene 53630', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(90, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/538', 'NCBI Gene 538', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(91, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/540', 'NCBI Gene 540', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(92, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/54805', 'NCBI Gene 54805', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(93, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/55065', 'NCBI Gene 55065', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(94, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/55163', 'NCBI Gene 55163', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(95, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/55191', 'NCBI Gene 55191', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(96, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/55312', 'NCBI Gene 55312', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(97, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/55503', 'NCBI Gene 55503', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(98, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/55630', 'NCBI Gene 55630', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(100, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/5950', 'NCBI Gene 5950', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(101, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/64116', 'NCBI Gene 64116', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(102, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/6414', 'NCBI Gene 6414', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(103, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/64220', 'NCBI Gene 64220', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(104, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/64802', 'NCBI Gene 64802', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(105, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/6528', 'NCBI Gene 6528', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(106, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/6557', 'NCBI Gene 6557', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(107, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/6573', 'NCBI Gene 6573', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(108, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/686', 'NCBI Gene 686', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(109, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/6948', 'NCBI Gene 6948', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(112, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/7038', 'NCBI Gene 7038', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(113, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/7173', 'NCBI Gene 7173', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(114, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/7274', 'NCBI Gene 7274', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(115, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/7421', 'NCBI Gene 7421', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(116, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/7779', 'NCBI Gene 7779', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(117, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/79001', 'NCBI Gene 79001', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(118, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/79581', 'NCBI Gene 79581', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(119, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/8029', 'NCBI Gene 8029', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(120, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/80308', 'NCBI Gene 80308', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(121, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/80704', 'NCBI Gene 80704', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(122, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/846', 'NCBI Gene 846', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(123, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/8529', 'NCBI Gene 8529', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(124, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/8566', 'NCBI Gene 8566', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(125, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/8884', 'NCBI Gene 8884', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.');
INSERT INTO `dataset_sources` (`source_id`, `dataset_name`, `organization`, `source_url`, `record_identifier`, `version_or_release`, `access_date`, `license`, `verification_status`) VALUES
(126, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/93100', 'NCBI Gene 93100', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(127, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/9962', 'NCBI Gene 9962', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(128, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/9963', 'NCBI Gene 9963', 'Current NCBI Gene record', '2026-10-24', 'NCBI data are publicly accessible; third-party notices may apply.', 'Human gene record identity and current summary checked through NCBI E-utilities on 2026-10-24. Biological function does not establish dietary deficiency.'),
(139, 'Biological pathway associations', 'Reactome', 'https://reactome.org/content/detail/R-HSA-1296067', 'R-HSA-1296067', 'Reactome pathway stable ID', '2026-10-24', 'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms', 'Exact Homo sapiens pathway name and stable identifier verified against Reactome ContentService on 2026-10-24.'),
(142, 'Biological pathway associations', 'Reactome', 'https://reactome.org/content/detail/R-HSA-196780', 'R-HSA-196780', 'Reactome pathway stable ID', '2026-10-24', 'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms', 'Exact Homo sapiens pathway name and stable identifier verified against Reactome ContentService on 2026-10-24.'),
(144, 'Biological pathway associations', 'Reactome', 'https://reactome.org/content/detail/R-HSA-196819', 'R-HSA-196819', 'Reactome pathway stable ID', '2026-10-24', 'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms', 'Exact Homo sapiens pathway name and stable identifier verified against Reactome ContentService on 2026-10-24.'),
(145, 'Biological pathway associations', 'Reactome', 'https://reactome.org/content/detail/R-HSA-196836', 'R-HSA-196836', 'Reactome pathway stable ID', '2026-10-24', 'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms', 'Exact Homo sapiens pathway name and stable identifier verified against Reactome ContentService on 2026-10-24.'),
(146, 'Biological pathway associations', 'Reactome', 'https://reactome.org/content/detail/R-HSA-196843', 'R-HSA-196843', 'Reactome pathway stable ID', '2026-10-24', 'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms', 'Exact Homo sapiens pathway name and stable identifier verified against Reactome ContentService on 2026-10-24.'),
(147, 'Biological pathway associations', 'Reactome', 'https://reactome.org/content/detail/R-HSA-196849', 'R-HSA-196849', 'Reactome pathway stable ID', '2026-10-24', 'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms', 'Exact Homo sapiens pathway name and stable identifier verified against Reactome ContentService on 2026-10-24.'),
(148, 'Biological pathway associations', 'Reactome', 'https://reactome.org/content/detail/R-HSA-2408522', 'R-HSA-2408522', 'Reactome pathway stable ID', '2026-10-24', 'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms', 'Exact Homo sapiens pathway name and stable identifier verified against Reactome ContentService on 2026-10-24.'),
(149, 'Biological pathway associations', 'Reactome', 'https://reactome.org/content/detail/R-HSA-350864', 'R-HSA-350864', 'Reactome pathway stable ID', '2026-10-24', 'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms', 'Exact Homo sapiens pathway name and stable identifier verified against Reactome ContentService on 2026-10-24.'),
(150, 'Biological pathway associations', 'Reactome', 'https://reactome.org/content/detail/R-HSA-425410', 'R-HSA-425410', 'Reactome pathway stable ID', '2026-10-24', 'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms', 'Exact Homo sapiens pathway name and stable identifier verified against Reactome ContentService on 2026-10-24.'),
(151, 'Biological pathway associations', 'Reactome', 'https://reactome.org/content/detail/R-HSA-435354', 'R-HSA-435354', 'Reactome pathway stable ID', '2026-10-24', 'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms', 'Exact Homo sapiens pathway name and stable identifier verified against Reactome ContentService on 2026-10-24.'),
(154, 'Biological pathway associations', 'Reactome', 'https://reactome.org/content/detail/R-HSA-8949215', 'R-HSA-8949215', 'Reactome pathway stable ID', '2026-10-24', 'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms', 'Exact Homo sapiens pathway name and stable identifier verified against Reactome ContentService on 2026-10-24.'),
(156, 'Biological pathway associations', 'Reactome', 'https://reactome.org/content/detail/R-HSA-964975', 'R-HSA-964975', 'Reactome pathway stable ID', '2026-10-24', 'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms', 'Exact Homo sapiens pathway name and stable identifier verified against Reactome ContentService on 2026-10-24.'),
(157, 'Biological pathway associations', 'Reactome', 'https://reactome.org/content/detail/R-HSA-975634', 'R-HSA-975634', 'Reactome pathway stable ID', '2026-10-24', 'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms', 'Exact Homo sapiens pathway name and stable identifier verified against Reactome ContentService on 2026-10-24.'),
(158, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/O00764', 'UniProt accession O00764', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(159, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/O15431', 'UniProt accession O15431', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(160, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/O15528', 'UniProt accession O15528', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(161, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/O60494', 'UniProt accession O60494', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(162, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/O60779', 'UniProt accession O60779', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(163, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/O94903', 'UniProt accession O94903', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(164, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P00374', 'UniProt accession P00374', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(165, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P00450', 'UniProt accession P00450', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(166, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P01266', 'UniProt accession P01266', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(167, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P02753', 'UniProt accession P02753', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(168, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P02774', 'UniProt accession P02774', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(171, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P04114', 'UniProt accession P04114', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(172, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P05023', 'UniProt accession P05023', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(173, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P05186', 'UniProt accession P05186', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(174, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P07202', 'UniProt accession P07202', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(175, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P07203', 'UniProt accession P07203', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(176, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P11473', 'UniProt accession P11473', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(177, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P20062', 'UniProt accession P20062', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(178, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P27352', 'UniProt accession P27352', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(179, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P35670', 'UniProt accession P35670', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(180, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P38435', 'UniProt accession P38435', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(181, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P41180', 'UniProt accession P41180', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(182, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P41440', 'UniProt accession P41440', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(183, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P42898', 'UniProt accession P42898', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(184, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P43251', 'UniProt accession P43251', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(185, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P48048', 'UniProt accession P48048', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(186, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P49638', 'UniProt accession P49638', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(187, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P49908', 'UniProt accession P49908', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(188, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P50747', 'UniProt accession P50747', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(189, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P54710', 'UniProt accession P54710', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(190, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P78329', 'UniProt accession P78329', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(192, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q04656', 'UniProt accession Q04656', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(193, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q07973', 'UniProt accession Q07973', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(194, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q13621', 'UniProt accession Q13621', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(195, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q15274', 'UniProt accession Q15274', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(196, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q6IA69', 'UniProt accession Q6IA69', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(197, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q6P5W5', 'UniProt accession Q6P5W5', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(198, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q6PHW0', 'UniProt accession Q6PHW0', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(199, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q6XQN6', 'UniProt accession Q6XQN6', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(200, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q8IVJ1', 'UniProt accession Q8IVJ1', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(201, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q8NFF5', 'UniProt accession Q8NFF5', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(202, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q92911', 'UniProt accession Q92911', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(203, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q969G6', 'UniProt accession Q969G6', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(204, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q9BQB6', 'UniProt accession Q9BQB6', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(205, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q9BX79', 'UniProt accession Q9BX79', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(206, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q9BX84', 'UniProt accession Q9BX84', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(207, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q9BZV2', 'UniProt accession Q9BZV2', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(208, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q9C0K1', 'UniProt accession Q9C0K1', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(209, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q9H1D0', 'UniProt accession Q9H1D0', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(210, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q9H3S4', 'UniProt accession Q9H3S4', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(211, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q9H8M5', 'UniProt accession Q9H8M5', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(212, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q9HAB3', 'UniProt accession Q9HAB3', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(213, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q9HAN9', 'UniProt accession Q9HAN9', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(214, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q9HAY6', 'UniProt accession Q9HAY6', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(215, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q9HD40', 'UniProt accession Q9HD40', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(217, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q9NVS9', 'UniProt accession Q9NVS9', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(218, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q9NWF4', 'UniProt accession Q9NWF4', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(219, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q9UGH3', 'UniProt accession Q9UGH3', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(220, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q9UHI7', 'UniProt accession Q9UHI7', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(222, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q9Y289', 'UniProt accession Q9Y289', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(223, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q9Y4U1', 'UniProt accession Q9Y4U1', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.'),
(224, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q9Y6M5', 'UniProt accession Q9Y6M5', 'Reviewed UniProtKB entry', '2026-10-24', 'Consult current UniProtKB terms; no license assumption is made by this export.', 'Reviewed human UniProtKB entry and protein annotation checked on 2026-10-24. Protein function does not diagnose dietary deficiency.');

-- --------------------------------------------------------

--
-- Table structure for table `deficiency_master`
--

CREATE TABLE `deficiency_master` (
  `deficiency_id` int(11) NOT NULL,
  `deficiency_name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `cause` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `deficiency_master`
--

INSERT INTO `deficiency_master` (`deficiency_id`, `deficiency_name`, `description`, `cause`) VALUES
(1, 'Iron Deficiency', 'Iron deficiency occurs when the body lacks enough iron to produce healthy red blood cells.', 'Poor dietary intake, blood loss, pregnancy, poor iron absorption.'),
(2, 'Vitamin D Deficiency', 'Vitamin D deficiency weakens bones and muscles by reducing calcium absorption.', 'Limited sunlight exposure, low dietary intake, kidney disorders.'),
(3, 'Vitamin B12 Deficiency', '', ''),
(4, 'Vitamin A Deficiency', 'Vitamin A deficiency affects vision, immunity, and healthy skin.', 'Low intake of carrots, dairy products, eggs, and leafy vegetables.'),
(5, 'Vitamin C Deficiency', 'Vitamin C deficiency reduces collagen production and weakens immunity.', 'Low intake of citrus fruits, smoking, poor nutrition.'),
(6, 'Vitamin E Deficiency', 'Vitamin E deficiency damages nerves and muscles due to antioxidant deficiency.', 'Fat malabsorption, poor nutrition, digestive disorders.'),
(7, 'Vitamin K Deficiency', 'Vitamin K deficiency affects blood clotting and bone health.', 'Poor intake of leafy vegetables, liver disease, antibiotics.'),
(8, 'Vitamin B1 Deficiency', 'Vitamin B1 deficiency affects the nervous system and energy production.', 'Poor diet, alcoholism, malnutrition.'),
(9, 'Vitamin B2 Deficiency', 'Vitamin B2 deficiency affects skin, eyes, and energy metabolism.', 'Poor dairy intake, alcoholism, malnutrition.'),
(10, 'Vitamin B3 Deficiency', 'Vitamin B3 deficiency causes pellagra and affects the digestive and nervous systems.', 'Poor nutrition, alcoholism, chronic illness.'),
(11, 'Vitamin B6 Deficiency', 'Vitamin B6 deficiency affects brain function and red blood cell formation.', 'Poor diet, kidney disease, certain medications.'),
(12, 'Biotin Deficiency', 'Biotin deficiency affects hair, skin, and nail health.', 'Poor nutrition, raw egg consumption, pregnancy.'),
(13, 'Folate Deficiency', 'Folate deficiency reduces healthy red blood cell production and DNA synthesis.', 'Poor intake of leafy vegetables, pregnancy, alcohol use.'),
(14, 'Calcium Deficiency', 'Calcium deficiency weakens bones and teeth.', 'Low dairy intake, vitamin D deficiency, hormonal disorders.'),
(15, 'Magnesium Deficiency', 'Magnesium deficiency affects muscles, nerves, and heart rhythm.', 'Poor diet, diabetes, alcoholism.'),
(16, 'Zinc Deficiency', 'Zinc deficiency weakens immunity and delays wound healing.', 'Poor diet, digestive disorders, vegetarian diets.'),
(17, 'Copper Deficiency', 'Copper deficiency affects blood formation and nervous system function.', 'Poor absorption, excessive zinc intake.'),
(18, 'Iodine Deficiency', 'Iodine deficiency reduces thyroid hormone production.', 'Low iodine intake, absence of iodized salt.'),
(19, 'Selenium Deficiency', 'Selenium deficiency weakens antioxidant defense and immunity.', 'Low selenium in soil and diet.'),
(20, 'Potassium Deficiency', 'Potassium deficiency affects muscles, nerves, and heart function.', 'Vomiting, diarrhea, diuretics, poor diet.');

-- --------------------------------------------------------

--
-- Table structure for table `deficiency_metadata`
--

CREATE TABLE `deficiency_metadata` (
  `deficiency_id` int(11) NOT NULL,
  `related_nutrient` varchar(100) NOT NULL,
  `source_url` varchar(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `deficiency_metadata`
--

INSERT INTO `deficiency_metadata` (`deficiency_id`, `related_nutrient`, `source_url`) VALUES
(1, 'Iron', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(2, 'Vitamin D', 'https://ods.od.nih.gov/factsheets/VitaminD-HealthProfessional/'),
(3, 'Vitamin B12', 'https://ods.od.nih.gov/factsheets/VitaminB12-HealthProfessional/'),
(4, 'Vitamin A', 'https://ods.od.nih.gov/factsheets/VitaminA-HealthProfessional/'),
(5, 'Vitamin C', 'https://ods.od.nih.gov/factsheets/VitaminC-HealthProfessional/'),
(6, 'Vitamin E', 'https://ods.od.nih.gov/factsheets/VitaminE-HealthProfessional/'),
(7, 'Vitamin K', 'https://ods.od.nih.gov/factsheets/VitaminK-HealthProfessional/'),
(8, 'Vitamin B1 (thiamin)', 'https://ods.od.nih.gov/factsheets/Thiamin-HealthProfessional/'),
(9, 'Vitamin B2 (riboflavin)', 'https://ods.od.nih.gov/factsheets/Riboflavin-HealthProfessional/'),
(10, 'Vitamin B3 (niacin)', 'https://ods.od.nih.gov/factsheets/Niacin-HealthProfessional/'),
(11, 'Vitamin B6', 'https://ods.od.nih.gov/factsheets/VitaminB6-HealthProfessional/'),
(12, 'Biotin', 'https://ods.od.nih.gov/factsheets/Biotin-HealthProfessional/'),
(13, 'Folate', 'https://ods.od.nih.gov/factsheets/Folate-HealthProfessional/'),
(14, 'Calcium', 'https://ods.od.nih.gov/factsheets/Calcium-HealthProfessional/'),
(15, 'Magnesium', 'https://ods.od.nih.gov/factsheets/Magnesium-HealthProfessional/'),
(16, 'Zinc', 'https://ods.od.nih.gov/factsheets/Zinc-HealthProfessional/'),
(17, 'Copper', 'https://ods.od.nih.gov/factsheets/Copper-HealthProfessional/'),
(18, 'Iodine', 'https://ods.od.nih.gov/factsheets/Iodine-HealthProfessional/'),
(19, 'Selenium', 'https://ods.od.nih.gov/factsheets/Selenium-HealthProfessional/'),
(20, 'Potassium', 'https://ods.od.nih.gov/factsheets/Potassium-HealthProfessional/');

-- --------------------------------------------------------

--
-- Table structure for table `deficiency_symptoms`
--

CREATE TABLE `deficiency_symptoms` (
  `id` int(11) NOT NULL,
  `deficiency_id` int(11) NOT NULL,
  `symptom_id` int(11) NOT NULL,
  `weight` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `deficiency_symptoms`
--

INSERT INTO `deficiency_symptoms` (`id`, `deficiency_id`, `symptom_id`, `weight`) VALUES
(1, 1, 1, 5),
(2, 1, 2, 4),
(3, 1, 4, 5),
(4, 1, 18, 5),
(5, 1, 19, 3),
(6, 2, 8, 5),
(7, 2, 7, 3),
(8, 2, 14, 2),
(9, 3, 9, 5),
(10, 3, 10, 4),
(11, 3, 13, 5),
(12, 3, 14, 3),
(13, 4, 5, 5),
(14, 4, 2, 3),
(15, 5, 11, 5),
(16, 5, 2, 3),
(17, 7, 9, 5),
(18, 8, 1, 5),
(19, 8, 2, 4),
(20, 9, 10, 4),
(21, 9, 7, 2),
(22, 10, 16, 4),
(23, 10, 14, 2),
(24, 11, 16, 4),
(25, 11, 10, 3),
(26, 12, 3, 5),
(27, 12, 17, 4),
(28, 12, 7, 3),
(29, 13, 1, 5),
(30, 13, 4, 5),
(31, 13, 2, 4),
(32, 14, 5, 5),
(33, 14, 6, 4),
(34, 15, 6, 5),
(35, 15, 11, 3),
(36, 15, 12, 3),
(37, 16, 13, 4),
(38, 16, 17, 4),
(39, 16, 3, 3),
(40, 17, 3, 4),
(41, 17, 4, 3),
(42, 18, 20, 5),
(43, 18, 1, 2),
(44, 19, 3, 3),
(45, 19, 1, 3),
(46, 20, 6, 5),
(47, 20, 2, 4),
(48, 20, 19, 3);

-- --------------------------------------------------------

--
-- Table structure for table `deficiency_symptom_metadata`
--

CREATE TABLE `deficiency_symptom_metadata` (
  `deficiency_id` int(11) NOT NULL,
  `symptom_id` int(11) NOT NULL,
  `evidence_note` text NOT NULL,
  `source_url` varchar(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `deficiency_symptom_metadata`
--

INSERT INTO `deficiency_symptom_metadata` (`deficiency_id`, `symptom_id`, `evidence_note`, `source_url`) VALUES
(1, 1, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(1, 2, 'Existing DefiMap rule weight 4/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(1, 4, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(1, 18, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(1, 19, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(2, 7, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminD-HealthProfessional/'),
(2, 8, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminD-HealthProfessional/'),
(2, 14, 'Existing DefiMap rule weight 2/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminD-HealthProfessional/'),
(3, 9, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminB12-HealthProfessional/'),
(3, 10, 'Existing DefiMap rule weight 4/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminB12-HealthProfessional/'),
(3, 13, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminB12-HealthProfessional/'),
(3, 14, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminB12-HealthProfessional/'),
(4, 2, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminA-HealthProfessional/'),
(4, 5, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminA-HealthProfessional/'),
(5, 2, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminC-HealthProfessional/'),
(5, 11, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminC-HealthProfessional/'),
(7, 9, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminK-HealthProfessional/'),
(8, 1, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Thiamin-HealthProfessional/'),
(8, 2, 'Existing DefiMap rule weight 4/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Thiamin-HealthProfessional/'),
(9, 7, 'Existing DefiMap rule weight 2/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Riboflavin-HealthProfessional/'),
(9, 10, 'Existing DefiMap rule weight 4/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Riboflavin-HealthProfessional/'),
(10, 14, 'Existing DefiMap rule weight 2/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Niacin-HealthProfessional/'),
(10, 16, 'Existing DefiMap rule weight 4/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Niacin-HealthProfessional/'),
(11, 10, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminB6-HealthProfessional/'),
(11, 16, 'Existing DefiMap rule weight 4/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminB6-HealthProfessional/'),
(12, 3, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Biotin-HealthProfessional/'),
(12, 7, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Biotin-HealthProfessional/'),
(12, 17, 'Existing DefiMap rule weight 4/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Biotin-HealthProfessional/'),
(13, 1, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Folate-HealthProfessional/'),
(13, 2, 'Existing DefiMap rule weight 4/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Folate-HealthProfessional/'),
(13, 4, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Folate-HealthProfessional/'),
(14, 5, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Calcium-HealthProfessional/'),
(14, 6, 'Existing DefiMap rule weight 4/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Calcium-HealthProfessional/'),
(15, 6, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Magnesium-HealthProfessional/'),
(15, 11, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Magnesium-HealthProfessional/'),
(15, 12, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Magnesium-HealthProfessional/'),
(16, 3, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Zinc-HealthProfessional/'),
(16, 13, 'Existing DefiMap rule weight 4/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Zinc-HealthProfessional/'),
(16, 17, 'Existing DefiMap rule weight 4/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Zinc-HealthProfessional/'),
(17, 3, 'Existing DefiMap rule weight 4/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Copper-HealthProfessional/'),
(17, 4, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Copper-HealthProfessional/'),
(18, 1, 'Existing DefiMap rule weight 2/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Iodine-HealthProfessional/'),
(18, 20, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Iodine-HealthProfessional/'),
(19, 1, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Selenium-HealthProfessional/'),
(19, 3, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Selenium-HealthProfessional/'),
(20, 2, 'Existing DefiMap rule weight 4/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Potassium-HealthProfessional/'),
(20, 6, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Potassium-HealthProfessional/'),
(20, 19, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Potassium-HealthProfessional/');

-- --------------------------------------------------------

--
-- Table structure for table `family_history_factors`
--

CREATE TABLE `family_history_factors` (
  `id` int(11) NOT NULL,
  `deficiency_id` int(11) DEFAULT NULL,
  `condition_name` varchar(100) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `family_history_factors`
--

INSERT INTO `family_history_factors` (`id`, `deficiency_id`, `condition_name`, `weight`) VALUES
(1, 1, 'Anemia', 5),
(2, 1, 'Iron Deficiency', 4);

-- --------------------------------------------------------

--
-- Table structure for table `food_nutrient_data`
--

CREATE TABLE `food_nutrient_data` (
  `food_record_id` int(11) NOT NULL,
  `fdc_id` int(11) NOT NULL,
  `food_name` varchar(255) NOT NULL,
  `nutrient_name` varchar(255) NOT NULL,
  `nutrient_amount` decimal(18,8) NOT NULL,
  `nutrient_unit` varchar(20) NOT NULL,
  `serving_basis` varchar(100) NOT NULL,
  `source_url` varchar(2048) NOT NULL,
  `verification_status` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `food_nutrient_data`
--

INSERT INTO `food_nutrient_data` (`food_record_id`, `fdc_id`, `food_name`, `nutrient_name`, `nutrient_amount`, `nutrient_unit`, `serving_basis`, `source_url`, `verification_status`) VALUES
(1, 1999632, 'Spinach, baby', 'Iron, Fe', 1.26100000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/1999632/nutrients', 'verified'),
(2, 1999632, 'Spinach, baby', 'Magnesium, Mg', 92.86000000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/1999632/nutrients', 'verified'),
(3, 1999632, 'Spinach, baby', 'Potassium, K', 581.80000000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/1999632/nutrients', 'verified'),
(4, 1999632, 'Spinach, baby', 'Zinc, Zn', 0.44710000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/1999632/nutrients', 'verified'),
(5, 1999632, 'Spinach, baby', 'Vitamin C, total ascorbic acid', 26.52000000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/1999632/nutrients', 'verified'),
(6, 1999632, 'Spinach, baby', 'Folate, total', 116.50000000, 'ug', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/1999632/nutrients', 'verified'),
(7, 2258590, 'Peppers, bell, red, raw', 'Iron, Fe', 0.35300000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2258590/nutrients', 'verified'),
(8, 2258590, 'Peppers, bell, red, raw', 'Magnesium, Mg', 11.00000000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2258590/nutrients', 'verified'),
(9, 2258590, 'Peppers, bell, red, raw', 'Potassium, K', 213.00000000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2258590/nutrients', 'verified'),
(10, 2258590, 'Peppers, bell, red, raw', 'Zinc, Zn', 0.20200000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2258590/nutrients', 'verified'),
(11, 2258590, 'Peppers, bell, red, raw', 'Vitamin C, total ascorbic acid', 142.00000000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2258590/nutrients', 'verified'),
(12, 2258590, 'Peppers, bell, red, raw', 'Thiamin', 0.05490000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2258590/nutrients', 'verified'),
(13, 2258590, 'Peppers, bell, red, raw', 'Riboflavin', 0.14200000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2258590/nutrients', 'verified'),
(14, 2258590, 'Peppers, bell, red, raw', 'Niacin', 1.02000000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2258590/nutrients', 'verified'),
(15, 2258590, 'Peppers, bell, red, raw', 'Vitamin B-6', 0.30300000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2258590/nutrients', 'verified'),
(16, 2258590, 'Peppers, bell, red, raw', 'Folate, total', 47.30000000, 'ug', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2258590/nutrients', 'verified'),
(17, 2258590, 'Peppers, bell, red, raw', 'Calcium, Ca', 6.36000000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2258590/nutrients', 'verified'),
(18, 2684441, 'Fish, salmon, Atlantic, farm raised, raw', 'Iron, Fe', 0.25900000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2684441/nutrients', 'verified'),
(19, 2684441, 'Fish, salmon, Atlantic, farm raised, raw', 'Magnesium, Mg', 25.40000000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2684441/nutrients', 'verified'),
(20, 2684441, 'Fish, salmon, Atlantic, farm raised, raw', 'Potassium, K', 378.00000000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2684441/nutrients', 'verified'),
(21, 2684441, 'Fish, salmon, Atlantic, farm raised, raw', 'Zinc, Zn', 0.33900000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2684441/nutrients', 'verified'),
(22, 2684441, 'Fish, salmon, Atlantic, farm raised, raw', 'Selenium, Se', 22.80000000, 'ug', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2684441/nutrients', 'verified'),
(23, 2684441, 'Fish, salmon, Atlantic, farm raised, raw', 'Calcium, Ca', 9.42000000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2684441/nutrients', 'verified'),
(24, 2515380, 'Seeds, pumpkin seeds (pepitas), raw', 'Iron, Fe', 8.36000000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2515380/nutrients', 'verified'),
(25, 2515380, 'Seeds, pumpkin seeds (pepitas), raw', 'Magnesium, Mg', 500.00000000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2515380/nutrients', 'verified'),
(26, 2515380, 'Seeds, pumpkin seeds (pepitas), raw', 'Potassium, K', 691.00000000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2515380/nutrients', 'verified'),
(27, 2515380, 'Seeds, pumpkin seeds (pepitas), raw', 'Zinc, Zn', 6.34000000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2515380/nutrients', 'verified'),
(28, 2515380, 'Seeds, pumpkin seeds (pepitas), raw', 'Selenium, Se', 20.50000000, 'ug', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2515380/nutrients', 'verified'),
(29, 2515380, 'Seeds, pumpkin seeds (pepitas), raw', 'Calcium, Ca', 37.40000000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2515380/nutrients', 'verified'),
(30, 2515381, 'Seeds, sunflower seed, kernel, raw', 'Iron, Fe', 4.37000000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2515381/nutrients', 'verified'),
(31, 2515381, 'Seeds, sunflower seed, kernel, raw', 'Magnesium, Mg', 302.00000000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2515381/nutrients', 'verified'),
(32, 2515381, 'Seeds, sunflower seed, kernel, raw', 'Potassium, K', 657.00000000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2515381/nutrients', 'verified'),
(33, 2515381, 'Seeds, sunflower seed, kernel, raw', 'Zinc, Zn', 5.58000000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2515381/nutrients', 'verified'),
(34, 2515381, 'Seeds, sunflower seed, kernel, raw', 'Selenium, Se', 17.80000000, 'ug', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2515381/nutrients', 'verified'),
(35, 2515381, 'Seeds, sunflower seed, kernel, raw', 'Calcium, Ca', 116.00000000, 'mg', 'per 100 g (Foundation food record)', 'https://fdc.nal.usda.gov/food-details/2515381/nutrients', 'verified'),
(36, 321900, 'Broccoli, raw', 'Calcium, Ca', 46.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/321900/nutrients', 'verified'),
(37, 324038, 'Sauce, salsa, ready-to-serve', 'Calcium, Ca', 28.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/324038/nutrients', 'verified'),
(38, 325871, 'Bread, white, commercially prepared', 'Calcium, Ca', 211.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/325871/nutrients', 'verified'),
(39, 327923, 'Lettuce, cos or romaine, raw', 'Calcium, Ca', 35.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/327923/nutrients', 'verified'),
(40, 330869, 'Turkey, ground, 93% lean, 7% fat, pan-broiled crumbles', 'Calcium, Ca', 31.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/330869/nutrients', 'verified'),
(41, 333476, 'Fish, pollock, raw', 'Calcium, Ca', 15.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/333476/nutrients', 'verified'),
(42, 335061, 'Beef, short loin, t-bone steak, bone-in, separable lean only, trimmed to 1/8\" fat, choice, cooked, grilled', 'Calcium, Ca', 19.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/335061/nutrients', 'verified'),
(43, 335695, 'Beans, Dry, Pinto (0% moisture)', 'Calcium, Ca', 161.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/335695/nutrients', 'verified'),
(44, 746760, 'Beef, round, eye of round roast, boneless, separable lean only, trimmed to 0\" fat, select, raw', 'Calcium, Ca', 13.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746760/nutrients', 'verified'),
(45, 746771, 'Oranges, raw, navels', 'Calcium, Ca', 43.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746771/nutrients', 'verified'),
(46, 746783, 'Sausage, turkey, breakfast links, mild, raw', 'Calcium, Ca', 32.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746783/nutrients', 'verified'),
(47, 747436, 'Beans, Dry, Carioca (0% moisture)', 'Calcium, Ca', 194.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/747436/nutrients', 'verified'),
(48, 747447, 'Broccoli, raw', 'Calcium, Ca', 46.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/747447/nutrients', 'verified'),
(49, 790214, 'Flour, rice, white, unenriched', 'Calcium, Ca', 6.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/790214/nutrients', 'verified'),
(50, 1104962, 'Onions, white, raw', 'Calcium, Ca', 21.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1104962/nutrients', 'verified'),
(51, 1750341, 'Apples, gala, with skin, raw', 'Calcium, Ca', 6.63900000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1750341/nutrients', 'verified'),
(52, 1999628, 'Mushrooms, shiitake', 'Calcium, Ca', 0.76630000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1999628/nutrients', 'verified'),
(53, 2003590, 'Apple juice, with added vitamin C, from concentrate, shelf stable', 'Calcium, Ca', 7.09900000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003590/nutrients', 'verified'),
(54, 2003601, 'Mushroom, crimini', 'Calcium, Ca', 4.10500000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003601/nutrients', 'verified'),
(55, 2258591, 'Peppers, bell, orange, raw', 'Calcium, Ca', 4.89900000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2258591/nutrients', 'verified'),
(56, 2262074, 'Almond butter, creamy', 'Calcium, Ca', 263.80000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2262074/nutrients', 'verified'),
(57, 2346387, 'Cream, sour, full fat', 'Calcium, Ca', 107.20000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346387/nutrients', 'verified'),
(58, 2346398, 'Pineapple, raw', 'Calcium, Ca', 12.50000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346398/nutrients', 'verified'),
(59, 2346410, 'Raspberries, raw', 'Calcium, Ca', 16.41000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346410/nutrients', 'verified'),
(60, 2512377, 'Flour, cassava', 'Calcium, Ca', 74.55000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2512377/nutrients', 'verified'),
(61, 2515374, 'Nuts, cashew nuts, raw', 'Calcium, Ca', 41.95000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2515374/nutrients', 'verified'),
(62, 2644285, 'Beans, black, canned, sodium added, drained and rinsed', 'Calcium, Ca', 43.31000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2644285/nutrients', 'verified'),
(63, 2646169, 'Pork, loin, tenderloin, boneless, raw', 'Calcium, Ca', 4.52800000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2646169/nutrients', 'verified'),
(64, 2647441, 'Cheese, oaxaca, solid', 'Calcium, Ca', 532.30000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2647441/nutrients', 'verified'),
(65, 2685571, 'Squash, winter, acorn, raw', 'Calcium, Ca', 24.82000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2685571/nutrients', 'verified'),
(66, 2685582, 'Tomato, puree, canned', 'Calcium, Ca', 17.64000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2685582/nutrients', 'verified'),
(67, 2710825, 'Rice, black, unenriched, raw', 'Calcium, Ca', 14.40000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2710825/nutrients', 'verified'),
(68, 2710836, 'Pear, Anjou, green, with skin, raw', 'Calcium, Ca', 9.98600000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2710836/nutrients', 'verified'),
(69, 2727569, 'Chicken, breast, meat and skin, raw', 'Calcium, Ca', 6.89800000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2727569/nutrients', 'verified'),
(70, 2727580, 'Rutabaga, peeled, raw', 'Calcium, Ca', 42.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2727580/nutrients', 'verified'),
(71, 2747653, 'Beet greens, raw', 'Calcium, Ca', 72.80000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2747653/nutrients', 'verified'),
(72, 2747665, 'Radishes, red, raw', 'Calcium, Ca', 21.51000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2747665/nutrients', 'verified'),
(73, 2747676, 'Watermelon, seedless, rind only, raw', 'Calcium, Ca', 16.93000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2747676/nutrients', 'verified'),
(74, 2758995, 'Bread, mulitgrain, commercial', 'Calcium, Ca', 106.50000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2758995/nutrients', 'verified'),
(75, 321900, 'Broccoli, raw', 'Iron, Fe', 0.69000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/321900/nutrients', 'verified'),
(76, 324038, 'Sauce, salsa, ready-to-serve', 'Iron, Fe', 0.42000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/324038/nutrients', 'verified'),
(77, 325871, 'Bread, white, commercially prepared', 'Iron, Fe', 3.36000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/325871/nutrients', 'verified'),
(78, 327699, 'Strawberries, raw', 'Iron, Fe', 0.28000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/327699/nutrients', 'verified'),
(79, 330869, 'Turkey, ground, 93% lean, 7% fat, pan-broiled crumbles', 'Iron, Fe', 1.56000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/330869/nutrients', 'verified'),
(80, 333476, 'Fish, pollock, raw', 'Iron, Fe', 0.22000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/333476/nutrients', 'verified'),
(81, 335061, 'Beef, short loin, t-bone steak, bone-in, separable lean only, trimmed to 1/8\" fat, choice, cooked, grilled', 'Iron, Fe', 3.53000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/335061/nutrients', 'verified'),
(82, 335695, 'Beans, Dry, Pinto (0% moisture)', 'Iron, Fe', 5.40000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/335695/nutrients', 'verified'),
(83, 746760, 'Beef, round, eye of round roast, boneless, separable lean only, trimmed to 0\" fat, select, raw', 'Iron, Fe', 1.37000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746760/nutrients', 'verified'),
(84, 746771, 'Oranges, raw, navels', 'Iron, Fe', 0.33000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746771/nutrients', 'verified'),
(85, 746782, 'Milk, whole, 3.25% milkfat, with added vitamin D', 'Iron, Fe', 0.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746782/nutrients', 'verified'),
(86, 747435, 'Beans, Dry, Light Tan (0% moisture)', 'Iron, Fe', 7.29000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/747435/nutrients', 'verified'),
(87, 747447, 'Broccoli, raw', 'Iron, Fe', 0.69000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/747447/nutrients', 'verified'),
(88, 790214, 'Flour, rice, white, unenriched', 'Iron, Fe', 0.22000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/790214/nutrients', 'verified'),
(89, 1104962, 'Onions, white, raw', 'Iron, Fe', 0.15000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1104962/nutrients', 'verified'),
(90, 1750341, 'Apples, gala, with skin, raw', 'Iron, Fe', 0.06013000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1750341/nutrients', 'verified'),
(91, 1999627, 'Mushroom, oyster', 'Iron, Fe', 0.69810000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1999627/nutrients', 'verified'),
(92, 2003590, 'Apple juice, with added vitamin C, from concentrate, shelf stable', 'Iron, Fe', 0.04016000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003590/nutrients', 'verified'),
(93, 2003601, 'Mushroom, crimini', 'Iron, Fe', 0.31150000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003601/nutrients', 'verified'),
(94, 2259792, 'Buttermilk, low fat', 'Iron, Fe', 0.01325000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2259792/nutrients', 'verified'),
(95, 2262075, 'Flaxseed, ground', 'Iron, Fe', 5.77800000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2262075/nutrients', 'verified'),
(96, 2346388, 'Lettuce, iceberg, raw', 'Iron, Fe', 0.03325000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346388/nutrients', 'verified'),
(97, 2346399, 'Cherries, sweet, dark red, raw', 'Iron, Fe', 0.10540000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346399/nutrients', 'verified'),
(98, 2346410, 'Raspberries, raw', 'Iron, Fe', 0.45010000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346410/nutrients', 'verified'),
(99, 2512377, 'Flour, cassava', 'Iron, Fe', 3.98800000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2512377/nutrients', 'verified'),
(100, 2515374, 'Nuts, cashew nuts, raw', 'Iron, Fe', 5.98800000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2515374/nutrients', 'verified'),
(101, 2644285, 'Beans, black, canned, sodium added, drained and rinsed', 'Iron, Fe', 1.68800000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2644285/nutrients', 'verified'),
(102, 2646170, 'Chicken, breast, boneless, skinless, raw', 'Iron, Fe', 0.35430000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2646170/nutrients', 'verified'),
(103, 2647442, 'Cheese, queso fresco, solid', 'Iron, Fe', 0.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2647442/nutrients', 'verified'),
(104, 2685571, 'Squash, winter, acorn, raw', 'Iron, Fe', 0.30780000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2685571/nutrients', 'verified'),
(105, 2685582, 'Tomato, puree, canned', 'Iron, Fe', 1.23700000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2685582/nutrients', 'verified'),
(106, 2710825, 'Rice, black, unenriched, raw', 'Iron, Fe', 1.11600000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2710825/nutrients', 'verified'),
(107, 2710836, 'Pear, Anjou, green, with skin, raw', 'Iron, Fe', 0.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2710836/nutrients', 'verified'),
(108, 2727569, 'Chicken, breast, meat and skin, raw', 'Iron, Fe', 0.35350000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2727569/nutrients', 'verified'),
(109, 2727580, 'Rutabaga, peeled, raw', 'Iron, Fe', 0.13730000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2727580/nutrients', 'verified'),
(110, 2747654, 'Cod, Pacific or Alaskan, frozen, wild caught', 'Iron, Fe', 0.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2747654/nutrients', 'verified'),
(111, 2747665, 'Radishes, red, raw', 'Iron, Fe', 0.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2747665/nutrients', 'verified'),
(112, 2747676, 'Watermelon, seedless, rind only, raw', 'Iron, Fe', 0.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2747676/nutrients', 'verified'),
(113, 2758995, 'Bread, mulitgrain, commercial', 'Iron, Fe', 2.41300000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2758995/nutrients', 'verified'),
(114, 321900, 'Broccoli, raw', 'Magnesium, Mg', 21.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/321900/nutrients', 'verified'),
(115, 324038, 'Sauce, salsa, ready-to-serve', 'Magnesium, Mg', 15.20000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/324038/nutrients', 'verified'),
(116, 325871, 'Bread, white, commercially prepared', 'Magnesium, Mg', 26.90000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/325871/nutrients', 'verified'),
(117, 327699, 'Strawberries, raw', 'Magnesium, Mg', 11.80000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/327699/nutrients', 'verified'),
(118, 330869, 'Turkey, ground, 93% lean, 7% fat, pan-broiled crumbles', 'Magnesium, Mg', 29.10000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/330869/nutrients', 'verified'),
(119, 333476, 'Fish, pollock, raw', 'Magnesium, Mg', 16.10000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/333476/nutrients', 'verified'),
(120, 335061, 'Beef, short loin, t-bone steak, bone-in, separable lean only, trimmed to 1/8\" fat, choice, cooked, grilled', 'Magnesium, Mg', 20.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/335061/nutrients', 'verified'),
(121, 335695, 'Beans, Dry, Pinto (0% moisture)', 'Magnesium, Mg', 170.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/335695/nutrients', 'verified'),
(122, 746760, 'Beef, round, eye of round roast, boneless, separable lean only, trimmed to 0\" fat, select, raw', 'Magnesium, Mg', 11.40000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746760/nutrients', 'verified'),
(123, 746771, 'Oranges, raw, navels', 'Magnesium, Mg', 10.70000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746771/nutrients', 'verified'),
(124, 746782, 'Milk, whole, 3.25% milkfat, with added vitamin D', 'Magnesium, Mg', 11.90000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746782/nutrients', 'verified'),
(125, 747435, 'Beans, Dry, Light Tan (0% moisture)', 'Magnesium, Mg', 178.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/747435/nutrients', 'verified'),
(126, 747447, 'Broccoli, raw', 'Magnesium, Mg', 21.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/747447/nutrients', 'verified'),
(127, 790214, 'Flour, rice, white, unenriched', 'Magnesium, Mg', 22.90000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/790214/nutrients', 'verified'),
(128, 1104962, 'Onions, white, raw', 'Magnesium, Mg', 9.30000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1104962/nutrients', 'verified'),
(129, 1750341, 'Apples, gala, with skin, raw', 'Magnesium, Mg', 4.94700000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1750341/nutrients', 'verified'),
(130, 1999627, 'Mushroom, oyster', 'Magnesium, Mg', 13.91000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1999627/nutrients', 'verified'),
(131, 2003590, 'Apple juice, with added vitamin C, from concentrate, shelf stable', 'Magnesium, Mg', 4.86100000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003590/nutrients', 'verified'),
(132, 2003601, 'Mushroom, crimini', 'Magnesium, Mg', 10.25000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003601/nutrients', 'verified'),
(133, 2259792, 'Buttermilk, low fat', 'Magnesium, Mg', 11.03000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2259792/nutrients', 'verified'),
(134, 2262075, 'Flaxseed, ground', 'Magnesium, Mg', 372.10000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2262075/nutrients', 'verified'),
(135, 2346388, 'Lettuce, iceberg, raw', 'Magnesium, Mg', 6.31100000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346388/nutrients', 'verified'),
(136, 2346399, 'Cherries, sweet, dark red, raw', 'Magnesium, Mg', 12.11000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346399/nutrients', 'verified'),
(137, 2346410, 'Raspberries, raw', 'Magnesium, Mg', 19.15000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346410/nutrients', 'verified'),
(138, 2512377, 'Flour, cassava', 'Magnesium, Mg', 33.56000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2512377/nutrients', 'verified'),
(139, 2515374, 'Nuts, cashew nuts, raw', 'Magnesium, Mg', 250.60000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2515374/nutrients', 'verified'),
(140, 2644285, 'Beans, black, canned, sodium added, drained and rinsed', 'Magnesium, Mg', 32.54000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2644285/nutrients', 'verified'),
(141, 2646170, 'Chicken, breast, boneless, skinless, raw', 'Magnesium, Mg', 26.20000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2646170/nutrients', 'verified'),
(142, 2647442, 'Cheese, queso fresco, solid', 'Magnesium, Mg', 27.64000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2647442/nutrients', 'verified'),
(143, 2685571, 'Squash, winter, acorn, raw', 'Magnesium, Mg', 23.75000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2685571/nutrients', 'verified'),
(144, 2685582, 'Tomato, puree, canned', 'Magnesium, Mg', 19.33000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2685582/nutrients', 'verified'),
(145, 2710825, 'Rice, black, unenriched, raw', 'Magnesium, Mg', 113.40000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2710825/nutrients', 'verified'),
(146, 2710836, 'Pear, Anjou, green, with skin, raw', 'Magnesium, Mg', 6.49400000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2710836/nutrients', 'verified'),
(147, 2727569, 'Chicken, breast, meat and skin, raw', 'Magnesium, Mg', 25.40000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2727569/nutrients', 'verified'),
(148, 2727580, 'Rutabaga, peeled, raw', 'Magnesium, Mg', 15.44000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2727580/nutrients', 'verified'),
(149, 2747654, 'Cod, Pacific or Alaskan, frozen, wild caught', 'Magnesium, Mg', 17.88000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2747654/nutrients', 'verified'),
(150, 2747665, 'Radishes, red, raw', 'Magnesium, Mg', 8.94400000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2747665/nutrients', 'verified'),
(151, 2747676, 'Watermelon, seedless, rind only, raw', 'Magnesium, Mg', 9.67300000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2747676/nutrients', 'verified'),
(152, 2758995, 'Bread, mulitgrain, commercial', 'Magnesium, Mg', 67.34000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2758995/nutrients', 'verified'),
(153, 321900, 'Broccoli, raw', 'Zinc, Zn', 0.42000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/321900/nutrients', 'verified'),
(154, 324038, 'Sauce, salsa, ready-to-serve', 'Zinc, Zn', 0.20000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/324038/nutrients', 'verified'),
(155, 325871, 'Bread, white, commercially prepared', 'Zinc, Zn', 0.88000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/325871/nutrients', 'verified'),
(156, 327699, 'Strawberries, raw', 'Zinc, Zn', 0.18000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/327699/nutrients', 'verified'),
(157, 330869, 'Turkey, ground, 93% lean, 7% fat, pan-broiled crumbles', 'Zinc, Zn', 3.77000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/330869/nutrients', 'verified'),
(158, 333476, 'Fish, pollock, raw', 'Zinc, Zn', 0.31000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/333476/nutrients', 'verified'),
(159, 335061, 'Beef, short loin, t-bone steak, bone-in, separable lean only, trimmed to 1/8\" fat, choice, cooked, grilled', 'Zinc, Zn', 4.69000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/335061/nutrients', 'verified'),
(160, 335695, 'Beans, Dry, Pinto (0% moisture)', 'Zinc, Zn', 3.43000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/335695/nutrients', 'verified'),
(161, 746760, 'Beef, round, eye of round roast, boneless, separable lean only, trimmed to 0\" fat, select, raw', 'Zinc, Zn', 3.38000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746760/nutrients', 'verified'),
(162, 746771, 'Oranges, raw, navels', 'Zinc, Zn', 0.11000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746771/nutrients', 'verified'),
(163, 746782, 'Milk, whole, 3.25% milkfat, with added vitamin D', 'Zinc, Zn', 0.42000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746782/nutrients', 'verified'),
(164, 747435, 'Beans, Dry, Light Tan (0% moisture)', 'Zinc, Zn', 3.23000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/747435/nutrients', 'verified'),
(165, 747447, 'Broccoli, raw', 'Zinc, Zn', 0.42000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/747447/nutrients', 'verified'),
(166, 790214, 'Flour, rice, white, unenriched', 'Zinc, Zn', 1.19000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/790214/nutrients', 'verified'),
(167, 1104962, 'Onions, white, raw', 'Zinc, Zn', 0.12000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1104962/nutrients', 'verified'),
(168, 1750341, 'Apples, gala, with skin, raw', 'Zinc, Zn', 0.02349000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1750341/nutrients', 'verified'),
(169, 1999627, 'Mushroom, oyster', 'Zinc, Zn', 0.68430000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1999627/nutrients', 'verified'),
(170, 2003590, 'Apple juice, with added vitamin C, from concentrate, shelf stable', 'Zinc, Zn', 0.00212500, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003590/nutrients', 'verified'),
(171, 2003601, 'Mushroom, crimini', 'Zinc, Zn', 0.51230000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003601/nutrients', 'verified'),
(172, 2259792, 'Buttermilk, low fat', 'Zinc, Zn', 0.42630000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2259792/nutrients', 'verified'),
(173, 2262075, 'Flaxseed, ground', 'Zinc, Zn', 4.73800000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2262075/nutrients', 'verified'),
(174, 2346388, 'Lettuce, iceberg, raw', 'Zinc, Zn', 0.17280000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346388/nutrients', 'verified'),
(175, 2346399, 'Cherries, sweet, dark red, raw', 'Zinc, Zn', 0.06446000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346399/nutrients', 'verified'),
(176, 2346410, 'Raspberries, raw', 'Zinc, Zn', 0.22130000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346410/nutrients', 'verified'),
(177, 2512377, 'Flour, cassava', 'Zinc, Zn', 0.40990000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2512377/nutrients', 'verified'),
(178, 2515374, 'Nuts, cashew nuts, raw', 'Zinc, Zn', 5.07100000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2515374/nutrients', 'verified'),
(179, 2644285, 'Beans, black, canned, sodium added, drained and rinsed', 'Zinc, Zn', 0.73990000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2644285/nutrients', 'verified'),
(180, 2646170, 'Chicken, breast, boneless, skinless, raw', 'Zinc, Zn', 0.65450000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2646170/nutrients', 'verified'),
(181, 2647442, 'Cheese, queso fresco, solid', 'Zinc, Zn', 2.90800000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2647442/nutrients', 'verified'),
(182, 2685571, 'Squash, winter, acorn, raw', 'Zinc, Zn', 0.29350000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2685571/nutrients', 'verified'),
(183, 2685582, 'Tomato, puree, canned', 'Zinc, Zn', 0.20840000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2685582/nutrients', 'verified'),
(184, 2710825, 'Rice, black, unenriched, raw', 'Zinc, Zn', 1.71600000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2710825/nutrients', 'verified'),
(185, 2710836, 'Pear, Anjou, green, with skin, raw', 'Zinc, Zn', 0.10740000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2710836/nutrients', 'verified'),
(186, 2727569, 'Chicken, breast, meat and skin, raw', 'Zinc, Zn', 0.62450000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2727569/nutrients', 'verified'),
(187, 2727580, 'Rutabaga, peeled, raw', 'Zinc, Zn', 0.21110000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2727580/nutrients', 'verified'),
(188, 2747654, 'Cod, Pacific or Alaskan, frozen, wild caught', 'Zinc, Zn', 0.26870000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2747654/nutrients', 'verified'),
(189, 2747665, 'Radishes, red, raw', 'Zinc, Zn', 0.10390000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2747665/nutrients', 'verified'),
(190, 2747676, 'Watermelon, seedless, rind only, raw', 'Zinc, Zn', 0.12100000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2747676/nutrients', 'verified'),
(191, 2758995, 'Bread, mulitgrain, commercial', 'Zinc, Zn', 1.53000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2758995/nutrients', 'verified'),
(192, 321359, 'Milk, reduced fat, fluid, 2% milkfat, with added vitamin A and vitamin D', 'Vitamin D (D2 + D3)', 1.10000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/321359/nutrients', 'verified'),
(193, 322559, 'Milk, nonfat, fluid, with added vitamin A and vitamin D (fat free or skim)', 'Vitamin D (D2 + D3)', 1.10000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/322559/nutrients', 'verified'),
(194, 323604, 'Egg, whole, raw, frozen, pasteurized', 'Vitamin D (D2 + D3)', 2.30000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/323604/nutrients', 'verified'),
(195, 323697, 'Egg, white, raw, frozen, pasteurized', 'Vitamin D (D2 + D3)', 0.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/323697/nutrients', 'verified'),
(196, 325198, 'Cheese, pasteurized process, American, vitamin D fortified', 'Vitamin D (D2 + D3)', 7.50000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/325198/nutrients', 'verified'),
(197, 326135, 'Cheese, swiss', 'Vitamin D (D2 + D3)', 0.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/326135/nutrients', 'verified'),
(198, 329596, 'Egg, yolk, raw, frozen, pasteurized', 'Vitamin D (D2 + D3)', 5.80000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/329596/nutrients', 'verified'),
(199, 329830, 'Cheese, dry white, queso seco', 'Vitamin D (D2 + D3)', 1.80000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/329830/nutrients', 'verified'),
(200, 330137, 'Yogurt, Greek, plain, nonfat', 'Vitamin D (D2 + D3)', 0.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/330137/nutrients', 'verified'),
(201, 331897, 'Chicken, broilers or fryers, drumstick, meat only, cooked, braised', 'Vitamin D (D2 + D3)', 0.10000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/331897/nutrients', 'verified'),
(202, 333374, 'Fish, haddock, raw', 'Vitamin D (D2 + D3)', 0.50000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/333374/nutrients', 'verified'),
(203, 334194, 'Fish, tuna, light, canned in water, drained solids', 'Vitamin D (D2 + D3)', 1.20000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/334194/nutrients', 'verified'),
(204, 334849, 'Beef, loin, top loin steak, boneless, lip-on, separable lean only, trimmed to 1/8\" fat, choice, raw', 'Vitamin D (D2 + D3)', 0.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/334849/nutrients', 'verified'),
(205, 334963, 'Beef, round, top round roast, boneless, separable lean only, trimmed to 0\" fat, select, raw', 'Vitamin D (D2 + D3)', 0.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/334963/nutrients', 'verified'),
(206, 746761, 'Beef, round, top round roast, boneless, separable lean only, trimmed to 0\" fat, select, raw', 'Vitamin D (D2 + D3)', 0.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746761/nutrients', 'verified'),
(207, 746767, 'Cheese, swiss', 'Vitamin D (D2 + D3)', 0.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746767/nutrients', 'verified'),
(208, 746772, 'Milk, lowfat, fluid, 1% milkfat, with added vitamin A and vitamin D', 'Vitamin D (D2 + D3)', 1.06000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746772/nutrients', 'verified'),
(209, 746778, 'Milk, reduced fat, fluid, 2% milkfat, with added vitamin A and vitamin D', 'Vitamin D (D2 + D3)', 1.13000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746778/nutrients', 'verified'),
(210, 746782, 'Milk, whole, 3.25% milkfat, with added vitamin D', 'Vitamin D (D2 + D3)', 0.96000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746782/nutrients', 'verified'),
(211, 790508, 'Butter, stick, salted', 'Vitamin D (D2 + D3)', 0.40000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/790508/nutrients', 'verified'),
(212, 1750338, 'Almond milk, unsweetened, plain, shelf stable', 'Vitamin D (D2 + D3)', 0.92700000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1750338/nutrients', 'verified'),
(213, 1999626, 'Mushroom, lion\'s mane', 'Vitamin D (D2 + D3)', 0.02120000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1999626/nutrients', 'verified'),
(214, 1999628, 'Mushrooms, shiitake', 'Vitamin D (D2 + D3)', 0.05620000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1999628/nutrients', 'verified'),
(215, 1999629, 'Mushrooms, white button', 'Vitamin D (D2 + D3)', 0.02170000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1999629/nutrients', 'verified'),
(216, 1999631, 'Almond milk, unsweetened, plain, shelf stable', 'Vitamin D (D2 + D3)', 0.92700000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1999631/nutrients', 'verified'),
(217, 2003599, 'Mushroom, king oyster', 'Vitamin D (D2 + D3)', 0.07000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003599/nutrients', 'verified'),
(218, 2003600, 'Mushroom, enoki', 'Vitamin D (D2 + D3)', 0.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003600/nutrients', 'verified'),
(219, 2003602, 'Mushroom, maitake', 'Vitamin D (D2 + D3)', 1.60000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003602/nutrients', 'verified'),
(220, 2003604, 'Mushroom, pioppini', 'Vitamin D (D2 + D3)', 0.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003604/nutrients', 'verified'),
(221, 2257044, 'Soy milk, sweetened, plain, refrigerated', 'Vitamin D (D2 + D3)', 4.63000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2257044/nutrients', 'verified'),
(222, 2257046, 'Oat milk, unsweetened, plain, refrigerated', 'Vitamin D (D2 + D3)', 1.70000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2257046/nutrients', 'verified'),
(223, 2259792, 'Buttermilk, low fat', 'Vitamin D (D2 + D3)', 0.54300000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2259792/nutrients', 'verified'),
(224, 2259794, 'Yogurt, Greek, plain, whole milk', 'Vitamin D (D2 + D3)', 0.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2259794/nutrients', 'verified'),
(225, 2259796, 'Cheese, feta, whole milk, crumbled', 'Vitamin D (D2 + D3)', 0.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2259796/nutrients', 'verified'),
(226, 2647437, 'Yogurt, plain, nonfat', 'Vitamin D (D2 + D3)', 0.21700000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2647437/nutrients', 'verified'),
(227, 2647439, 'Cheese, pasteurized process cheese food or product, American, singles', 'Vitamin D (D2 + D3)', 4.42000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2647439/nutrients', 'verified'),
(228, 2647440, 'Cheese, provolone, sliced', 'Vitamin D (D2 + D3)', 0.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2647440/nutrients', 'verified'),
(229, 2647442, 'Cheese, queso fresco, solid', 'Vitamin D (D2 + D3)', 0.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2647442/nutrients', 'verified'),
(230, 2768188, 'Alaska Pollock, raw', 'Vitamin D (D2 + D3)', 0.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2768188/nutrients', 'verified'),
(231, 321360, 'Tomatoes, grape, raw', 'Vitamin C, total ascorbic acid', 27.20000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/321360/nutrients', 'verified'),
(232, 324157, 'Sausage, breakfast sausage, beef, pre-cooked, unprepared', 'Vitamin C, total ascorbic acid', 19.20000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/324157/nutrients', 'verified'),
(233, 325287, 'Grapefruit juice, white, canned or bottled, unsweetened', 'Vitamin C, total ascorbic acid', 39.40000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/325287/nutrients', 'verified'),
(234, 326458, 'Carrots, frozen, unprepared (Includes foods for USDA\'s Food Distribution Program)', 'Vitamin C, total ascorbic acid', 2.20000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/326458/nutrients', 'verified'),
(235, 327046, 'Kiwifruit, green, raw', 'Vitamin C, total ascorbic acid', 74.70000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/327046/nutrients', 'verified'),
(236, 327699, 'Strawberries, raw', 'Vitamin C, total ascorbic acid', 36.30000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/327699/nutrients', 'verified'),
(237, 332791, 'Olives, green, Manzanilla, stuffed with pimiento', 'Vitamin C, total ascorbic acid', 0.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/332791/nutrients', 'verified'),
(238, 746764, 'Carrots, frozen, unprepared', 'Vitamin C, total ascorbic acid', 2.20000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746764/nutrients', 'verified'),
(239, 746771, 'Oranges, raw, navels', 'Vitamin C, total ascorbic acid', 59.10000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746771/nutrients', 'verified'),
(240, 746779, 'Sausage, breakfast sausage, beef, pre-cooked, unprepared', 'Vitamin C, total ascorbic acid', 19.20000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746779/nutrients', 'verified'),
(241, 790646, 'Onions, yellow, raw', 'Vitamin C, total ascorbic acid', 8.20000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/790646/nutrients', 'verified'),
(242, 1104647, 'Garlic, raw', 'Vitamin C, total ascorbic acid', 10.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1104647/nutrients', 'verified'),
(243, 1750353, 'Spinach, mature', 'Vitamin C, total ascorbic acid', 30.27000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1750353/nutrients', 'verified'),
(244, 1999634, 'Tomato, roma', 'Vitamin C, total ascorbic acid', 17.75000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1999634/nutrients', 'verified');
INSERT INTO `food_nutrient_data` (`food_record_id`, `fdc_id`, `food_name`, `nutrient_name`, `nutrient_amount`, `nutrient_unit`, `serving_basis`, `source_url`, `verification_status`) VALUES
(245, 2003593, 'Grape juice, white, with added vitamin C, from concentrate, shelf stable', 'Vitamin C, total ascorbic acid', 55.25000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003593/nutrients', 'verified'),
(246, 2003596, 'Tomato juice, with added ingredients, from concentrate, shelf stable', 'Vitamin C, total ascorbic acid', 49.80000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003596/nutrients', 'verified'),
(247, 2258591, 'Peppers, bell, orange, raw', 'Vitamin C, total ascorbic acid', 158.30000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2258591/nutrients', 'verified'),
(248, 2263889, 'Blueberries, raw', 'Vitamin C, total ascorbic acid', 8.05900000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2263889/nutrients', 'verified'),
(249, 2346390, 'Lettuce, leaf, red, raw', 'Vitamin C, total ascorbic acid', 9.34300000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346390/nutrients', 'verified'),
(250, 2346401, 'Potatoes, russet, without skin, raw', 'Vitamin C, total ascorbic acid', 10.90000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346401/nutrients', 'verified'),
(251, 2346404, 'Sweet potatoes, orange flesh, without skin, raw', 'Vitamin C, total ascorbic acid', 14.84000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346404/nutrients', 'verified'),
(252, 2346410, 'Raspberries, raw', 'Vitamin C, total ascorbic acid', 23.04000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346410/nutrients', 'verified'),
(253, 2346413, 'Grapes, green, seedless, raw', 'Vitamin C, total ascorbic acid', 3.01700000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346413/nutrients', 'verified'),
(254, 2685569, 'Squash, summer, yellow, includes skin, raw', 'Vitamin C, total ascorbic acid', 17.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2685569/nutrients', 'verified'),
(255, 2685572, 'Cabbage, bok choy, raw', 'Vitamin C, total ascorbic acid', 30.30000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2685572/nutrients', 'verified'),
(256, 2685576, 'Beets, raw', 'Vitamin C, total ascorbic acid', 4.60000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2685576/nutrients', 'verified'),
(257, 2685579, 'Tomato, sauce, canned, with salt added', 'Vitamin C, total ascorbic acid', 9.20000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2685579/nutrients', 'verified'),
(258, 2710815, 'Apricot, with skin, raw', 'Vitamin C, total ascorbic acid', 3.07100000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2710815/nutrients', 'verified'),
(259, 2710818, 'Plantains, underripe, raw', 'Vitamin C, total ascorbic acid', 18.53000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2710818/nutrients', 'verified'),
(260, 2710831, 'Kiwifruit (kiwi), green, peeled, raw', 'Vitamin C, total ascorbic acid', 58.78000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2710831/nutrients', 'verified'),
(261, 2710834, 'Mango, Ataulfo, peeled, raw', 'Vitamin C, total ascorbic acid', 168.10000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2710834/nutrients', 'verified'),
(262, 2727577, 'Pawpaw, peeled, seeded, raw', 'Vitamin C, total ascorbic acid', 27.60000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2727577/nutrients', 'verified'),
(263, 2727582, 'Tomatillos, dehusked, raw', 'Vitamin C, total ascorbic acid', 2.18100000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2727582/nutrients', 'verified'),
(264, 2727589, 'Juice, tart cherry, from concentrate, shelf-stable', 'Vitamin C, total ascorbic acid', 0.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2727589/nutrients', 'verified'),
(265, 2747660, 'Peppers, banana or Hungarian wax, seeded, raw', 'Vitamin C, total ascorbic acid', 112.10000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2747660/nutrients', 'verified'),
(266, 2747663, 'Peppers, serrano, seeded, raw', 'Vitamin C, total ascorbic acid', 94.61000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2747663/nutrients', 'verified'),
(267, 2747675, 'Watermelon, seedless, flesh only, raw', 'Vitamin C, total ascorbic acid', 6.45800000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2747675/nutrients', 'verified'),
(268, 2758976, 'Cranberries, dried, sweetened', 'Vitamin C, total ascorbic acid', 0.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2758976/nutrients', 'verified'),
(269, 2758980, 'Raisins, dark, seedless', 'Vitamin C, total ascorbic acid', 0.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2758980/nutrients', 'verified'),
(270, 321360, 'Tomatoes, grape, raw', 'Thiamin', 0.07500000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/321360/nutrients', 'verified'),
(271, 323294, 'Nuts, almonds, dry roasted, with salt added', 'Thiamin', 0.07900000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/323294/nutrients', 'verified'),
(272, 324653, 'Pickles, cucumber, dill or kosher dill', 'Thiamin', 0.04700000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/324653/nutrients', 'verified'),
(273, 325524, 'Seeds, sunflower seed kernels, dry roasted, with salt added', 'Thiamin', 0.47300000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/325524/nutrients', 'verified'),
(274, 326458, 'Carrots, frozen, unprepared (Includes foods for USDA\'s Food Distribution Program)', 'Thiamin', 0.03900000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/326458/nutrients', 'verified'),
(275, 327501, 'Oranges, raw, navels (Includes foods for USDA\'s Food Distribution Program)', 'Thiamin', 0.06800000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/327501/nutrients', 'verified'),
(276, 329830, 'Cheese, dry white, queso seco', 'Thiamin', 0.03800000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/329830/nutrients', 'verified'),
(277, 332597, 'Pears, raw, bartlett (Includes foods for USDA\'s Food Distribution Program)', 'Thiamin', 0.01200000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/332597/nutrients', 'verified'),
(278, 334194, 'Fish, tuna, light, canned in water, drained solids', 'Thiamin', 0.03000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/334194/nutrients', 'verified'),
(279, 335240, 'Bread, whole-wheat, commercially prepared', 'Thiamin', 0.39100000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/335240/nutrients', 'verified'),
(280, 746767, 'Cheese, swiss', 'Thiamin', 0.01100000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746767/nutrients', 'verified'),
(281, 746773, 'Pears, raw, bartlett', 'Thiamin', 0.01200000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746773/nutrients', 'verified'),
(282, 746780, 'Sausage, Italian, pork, mild, cooked, pan-fried', 'Thiamin', 0.31000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746780/nutrients', 'verified'),
(283, 747447, 'Broccoli, raw', 'Thiamin', 0.07700000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/747447/nutrients', 'verified'),
(284, 790085, 'Flour, whole wheat, unenriched', 'Thiamin', 0.50400000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/790085/nutrients', 'verified'),
(285, 1104705, 'Flour, soy, defatted', 'Thiamin', 0.54200000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1104705/nutrients', 'verified'),
(286, 1105314, 'Bananas, ripe and slightly ripe, raw', 'Thiamin', 0.05600000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1105314/nutrients', 'verified'),
(287, 1750337, 'Soy milk, unsweetened, plain, shelf stable', 'Thiamin', 0.06319000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1750337/nutrients', 'verified'),
(288, 1750343, 'Apples, honeycrisp, with skin, raw', 'Thiamin', 0.00875000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1750343/nutrients', 'verified'),
(289, 1750353, 'Spinach, mature', 'Thiamin', 0.07650000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1750353/nutrients', 'verified'),
(290, 1999629, 'Mushrooms, white button', 'Thiamin', 0.06500000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1999629/nutrients', 'verified'),
(291, 2003586, 'Flour, 00', 'Thiamin', 0.12500000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003586/nutrients', 'verified'),
(292, 2003592, 'Grape juice, purple, with added vitamin C, from concentrate, shelf stable', 'Thiamin', 0.02588000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003592/nutrients', 'verified'),
(293, 2003598, 'Mushroom, portabella', 'Thiamin', 0.00516700, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003598/nutrients', 'verified'),
(294, 2003604, 'Mushroom, pioppini', 'Thiamin', 0.01213000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003604/nutrients', 'verified'),
(295, 2258588, 'Peppers, bell, green, raw', 'Thiamin', 0.03906000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2258588/nutrients', 'verified'),
(296, 2259794, 'Yogurt, Greek, plain, whole milk', 'Thiamin', 0.05525000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2259794/nutrients', 'verified'),
(297, 2262072, 'Peanut butter, creamy', 'Thiamin', 0.12060000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2262072/nutrients', 'verified'),
(298, 2346386, 'Cream, heavy', 'Thiamin', 0.03225000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346386/nutrients', 'verified'),
(299, 2346392, 'Nuts, pine nuts, raw', 'Thiamin', 0.62530000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346392/nutrients', 'verified'),
(300, 2346398, 'Pineapple, raw', 'Thiamin', 0.06375000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346398/nutrients', 'verified'),
(301, 2512371, 'Flour, amaranth', 'Thiamin', 0.05875000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2512371/nutrients', 'verified'),
(302, 2512377, 'Flour, cassava', 'Thiamin', 0.05125000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2512377/nutrients', 'verified'),
(303, 2710819, 'Chia seeds, dry, raw', 'Thiamin', 0.50000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2710819/nutrients', 'verified'),
(304, 2710827, 'Einkorn, grain, dry, raw', 'Thiamin', 0.49000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2710827/nutrients', 'verified'),
(305, 2710839, 'Sorghum bran, white, unenriched, dry, raw', 'Thiamin', 0.55630000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2710839/nutrients', 'verified'),
(306, 2758976, 'Cranberries, dried, sweetened', 'Thiamin', 0.01018000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2758976/nutrients', 'verified'),
(307, 2758985, 'Refried beans, canned, vegetarian', 'Thiamin', 0.03000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2758985/nutrients', 'verified'),
(308, 2758998, 'Pasta, dry, enriched, spaghetti', 'Thiamin', 0.86570000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2758998/nutrients', 'verified'),
(309, 321360, 'Tomatoes, grape, raw', 'Riboflavin', 0.06500000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/321360/nutrients', 'verified'),
(310, 323121, 'Frankfurter, beef, unheated', 'Riboflavin', 0.15400000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/323121/nutrients', 'verified'),
(311, 324653, 'Pickles, cucumber, dill or kosher dill', 'Riboflavin', 0.05700000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/324653/nutrients', 'verified'),
(312, 325430, 'Peaches, yellow, raw', 'Riboflavin', 0.03100000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/325430/nutrients', 'verified'),
(313, 326135, 'Cheese, swiss', 'Riboflavin', 0.30300000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/326135/nutrients', 'verified'),
(314, 327198, 'Melons, cantaloupe, raw', 'Riboflavin', 0.02700000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/327198/nutrients', 'verified'),
(315, 328637, 'Cheese, cheddar', 'Riboflavin', 0.44100000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/328637/nutrients', 'verified'),
(316, 330415, 'Yogurt, Greek, strawberry, nonfat', 'Riboflavin', 0.25000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/330415/nutrients', 'verified'),
(317, 332864, 'Sausage, pork, chorizo, link or ground, cooked, pan-fried', 'Riboflavin', 0.42000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/332864/nutrients', 'verified'),
(318, 334462, 'Restaurant, Chinese, sweet and sour pork', 'Riboflavin', 0.10300000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/334462/nutrients', 'verified'),
(319, 334898, 'Beef, round, eye of round roast, boneless, separable lean only, trimmed to 0\" fat, select, raw', 'Riboflavin', 0.18500000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/334898/nutrients', 'verified'),
(320, 746759, 'Beef, loin, top loin steak, boneless, lip-on, separable lean only, trimmed to 1/8\" fat, choice, raw', 'Riboflavin', 0.20200000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746759/nutrients', 'verified'),
(321, 746764, 'Carrots, frozen, unprepared', 'Riboflavin', 0.04700000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746764/nutrients', 'verified'),
(322, 746769, 'Lettuce, cos or romaine, raw', 'Riboflavin', 0.07200000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746769/nutrients', 'verified'),
(323, 746774, 'Restaurant, Chinese, sweet and sour pork', 'Riboflavin', 0.10300000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746774/nutrients', 'verified'),
(324, 746782, 'Milk, whole, 3.25% milkfat, with added vitamin D', 'Riboflavin', 0.13800000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746782/nutrients', 'verified'),
(325, 747997, 'Eggs, Grade A, Large, egg white', 'Riboflavin', 0.39100000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/747997/nutrients', 'verified'),
(326, 790018, 'Flour, wheat, all-purpose, unenriched, unbleached', 'Riboflavin', 0.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/790018/nutrients', 'verified'),
(327, 790774, 'Bananas, overripe, raw', 'Riboflavin', 0.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/790774/nutrients', 'verified'),
(328, 1104867, 'Flour, rice, glutinous', 'Riboflavin', 0.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1104867/nutrients', 'verified'),
(329, 1105547, 'Apples, honeycrisp, with skin, raw', 'Riboflavin', 0.07400000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1105547/nutrients', 'verified'),
(330, 1750339, 'Apples, red delicious, with skin, raw', 'Riboflavin', 0.06625000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1750339/nutrients', 'verified'),
(331, 1750352, 'Spinach, baby', 'Riboflavin', 0.19350000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1750352/nutrients', 'verified'),
(332, 1999628, 'Mushrooms, shiitake', 'Riboflavin', 0.21630000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1999628/nutrients', 'verified'),
(333, 1999634, 'Tomato, roma', 'Riboflavin', 0.00000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1999634/nutrients', 'verified'),
(334, 2003598, 'Mushroom, portabella', 'Riboflavin', 0.46500000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003598/nutrients', 'verified'),
(335, 2003603, 'Mushroom, beech', 'Riboflavin', 0.20750000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003603/nutrients', 'verified'),
(336, 2258586, 'Carrots, mature, raw', 'Riboflavin', 0.09500000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2258586/nutrients', 'verified'),
(337, 2259793, 'Yogurt, plain, whole milk', 'Riboflavin', 0.24310000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2259793/nutrients', 'verified'),
(338, 2261421, 'Flour, oat, whole grain', 'Riboflavin', 0.16130000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2261421/nutrients', 'verified'),
(339, 2512374, 'Flour, buckwheat', 'Riboflavin', 0.16000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2512374/nutrients', 'verified'),
(340, 2512380, 'Rice, brown, long grain, unenriched, raw', 'Riboflavin', 0.10250000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2512380/nutrients', 'verified'),
(341, 2710843, 'Plantains, overripe, raw', 'Riboflavin', 0.10170000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2710843/nutrients', 'verified'),
(342, 2758977, 'Grapefruit, raw', 'Riboflavin', 0.10000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2758977/nutrients', 'verified'),
(343, 2758983, 'Beans, baked, canned, vegetarian', 'Riboflavin', 0.09917000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2758983/nutrients', 'verified'),
(344, 2758988, 'Dressing, Ranch', 'Riboflavin', 0.11630000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2758988/nutrients', 'verified'),
(345, 2758993, 'Bread, white, commercial', 'Riboflavin', 0.29920000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2758993/nutrients', 'verified'),
(346, 2759000, 'Pasta, dry, whole grain, spaghetti ', 'Riboflavin', 0.29000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2759000/nutrients', 'verified'),
(347, 2759005, 'Salami, hard, sliced', 'Riboflavin', 0.35920000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2759005/nutrients', 'verified'),
(348, 321900, 'Broccoli, raw', 'Niacin', 0.63900000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/321900/nutrients', 'verified'),
(349, 323444, 'Cheese, ricotta, whole milk', 'Niacin', 0.16800000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/323444/nutrients', 'verified'),
(350, 324860, 'Peanut butter, smooth style, with salt', 'Niacin', 13.30000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/324860/nutrients', 'verified'),
(351, 325658, 'Sausage, Italian, pork, mild, cooked, pan-fried', 'Niacin', 5.73000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/325658/nutrients', 'verified'),
(352, 326698, 'Mustard, prepared, yellow', 'Niacin', 0.56100000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/326698/nutrients', 'verified'),
(353, 327699, 'Strawberries, raw', 'Niacin', 0.38600000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/327699/nutrients', 'verified'),
(354, 330137, 'Yogurt, Greek, plain, nonfat', 'Niacin', 0.21100000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/330137/nutrients', 'verified'),
(355, 332791, 'Olives, green, Manzanilla, stuffed with pimiento', 'Niacin', 0.10300000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/332791/nutrients', 'verified'),
(356, 334628, 'Restaurant, Latino, tamale, pork', 'Niacin', 1.29000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/334628/nutrients', 'verified'),
(357, 335061, 'Beef, short loin, t-bone steak, bone-in, separable lean only, trimmed to 1/8\" fat, choice, cooked, grilled', 'Niacin', 6.37000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/335061/nutrients', 'verified'),
(358, 746761, 'Beef, round, top round roast, boneless, separable lean only, trimmed to 0\" fat, select, raw', 'Niacin', 6.16000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746761/nutrients', 'verified'),
(359, 746767, 'Cheese, swiss', 'Niacin', 0.06000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746767/nutrients', 'verified'),
(360, 746773, 'Pears, raw, bartlett', 'Niacin', 0.16400000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746773/nutrients', 'verified'),
(361, 746780, 'Sausage, Italian, pork, mild, cooked, pan-fried', 'Niacin', 5.73000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746780/nutrients', 'verified'),
(362, 747448, 'Strawberries, raw', 'Niacin', 0.38600000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/747448/nutrients', 'verified'),
(363, 790146, 'Flour, bread, white, enriched, unbleached', 'Niacin', 6.56000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/790146/nutrients', 'verified'),
(364, 1104766, 'Flour, soy, full-fat', 'Niacin', 2.74000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1104766/nutrients', 'verified'),
(365, 1105430, 'Apples, red delicious, with skin, raw', 'Niacin', 0.09000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1105430/nutrients', 'verified'),
(366, 1750338, 'Almond milk, unsweetened, plain, shelf stable', 'Niacin', 0.07438000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1750338/nutrients', 'verified'),
(367, 1750344, 'Mushroom, lion\'s mane', 'Niacin', 1.62600000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1750344/nutrients', 'verified'),
(368, 1750354, 'Tomato, roma', 'Niacin', 0.53310000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1750354/nutrients', 'verified'),
(369, 1999631, 'Almond milk, unsweetened, plain, shelf stable', 'Niacin', 0.07438000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1999631/nutrients', 'verified'),
(370, 2003588, 'Flour, semolina, coarse and semi-coarse', 'Niacin', 3.63200000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003588/nutrients', 'verified'),
(371, 2003595, 'Grapefruit juice, red, not fortified, not from concentrate, refrigerated', 'Niacin', 0.01875000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003595/nutrients', 'verified'),
(372, 2003601, 'Mushroom, crimini', 'Niacin', 4.17000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003601/nutrients', 'verified'),
(373, 2257046, 'Oat milk, unsweetened, plain, refrigerated', 'Niacin', 0.09625000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2257046/nutrients', 'verified'),
(374, 2259792, 'Buttermilk, low fat', 'Niacin', 0.12750000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2259792/nutrients', 'verified'),
(375, 2261421, 'Flour, oat, whole grain', 'Niacin', 1.94500000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2261421/nutrients', 'verified'),
(376, 2346384, 'Cottage cheese, full fat, large or small curd', 'Niacin', 0.13800000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346384/nutrients', 'verified'),
(377, 2346390, 'Lettuce, leaf, red, raw', 'Niacin', 0.32880000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346390/nutrients', 'verified'),
(378, 2346396, 'Oats, whole grain, rolled, old fashioned', 'Niacin', 0.99310000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346396/nutrients', 'verified'),
(379, 2346404, 'Sweet potatoes, orange flesh, without skin, raw', 'Niacin', 0.43250000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346404/nutrients', 'verified'),
(380, 2512376, 'Flour, barley', 'Niacin', 5.94100000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2512376/nutrients', 'verified'),
(381, 2710819, 'Chia seeds, dry, raw', 'Niacin', 8.67800000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2710819/nutrients', 'verified'),
(382, 2710827, 'Einkorn, grain, dry, raw', 'Niacin', 5.69100000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2710827/nutrients', 'verified'),
(383, 2710839, 'Sorghum bran, white, unenriched, dry, raw', 'Niacin', 24.65000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2710839/nutrients', 'verified'),
(384, 2758975, 'Rhubarb, stalk, raw', 'Niacin', 0.22560000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2758975/nutrients', 'verified'),
(385, 2758981, 'Edamame, frozen, prepared', 'Niacin', 0.90030000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2758981/nutrients', 'verified'),
(386, 2758997, 'Tortilla, corn, shelf stable', 'Niacin', 1.09100000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2758997/nutrients', 'verified'),
(387, 321900, 'Broccoli, raw', 'Vitamin B-6', 0.19100000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/321900/nutrients', 'verified'),
(388, 323505, 'Kale, raw', 'Vitamin B-6', 0.14700000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/323505/nutrients', 'verified'),
(389, 325198, 'Cheese, pasteurized process, American, vitamin D fortified', 'Vitamin B-6', 0.05600000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/325198/nutrients', 'verified'),
(390, 326135, 'Cheese, swiss', 'Vitamin B-6', 0.07000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/326135/nutrients', 'verified'),
(391, 327357, 'Nectarines, raw', 'Vitamin B-6', 0.02500000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/327357/nutrients', 'verified'),
(392, 329830, 'Cheese, dry white, queso seco', 'Vitamin B-6', 0.09100000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/329830/nutrients', 'verified'),
(393, 332864, 'Sausage, pork, chorizo, link or ground, cooked, pan-fried', 'Vitamin B-6', 0.55400000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/332864/nutrients', 'verified'),
(394, 334720, 'Restaurant, Latino, pupusas con frijoles (pupusas, bean)', 'Vitamin B-6', 0.17200000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/334720/nutrients', 'verified'),
(395, 335240, 'Bread, whole-wheat, commercially prepared', 'Vitamin B-6', 0.21600000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/335240/nutrients', 'verified'),
(396, 746764, 'Carrots, frozen, unprepared', 'Vitamin B-6', 0.08800000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746764/nutrients', 'verified'),
(397, 746771, 'Oranges, raw, navels', 'Vitamin B-6', 0.07900000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746771/nutrients', 'verified'),
(398, 746779, 'Sausage, breakfast sausage, beef, pre-cooked, unprepared', 'Vitamin B-6', 0.15000000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746779/nutrients', 'verified'),
(399, 747448, 'Strawberries, raw', 'Vitamin B-6', 0.03500000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/747448/nutrients', 'verified'),
(400, 790214, 'Flour, rice, white, unenriched', 'Vitamin B-6', 0.05200000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/790214/nutrients', 'verified'),
(401, 1104812, 'Flour, rice, brown', 'Vitamin B-6', 0.13200000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1104812/nutrients', 'verified'),
(402, 1105664, 'Apples, granny smith, with skin, raw', 'Vitamin B-6', 0.02800000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1105664/nutrients', 'verified'),
(403, 1750341, 'Apples, gala, with skin, raw', 'Vitamin B-6', 0.03175000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1750341/nutrients', 'verified'),
(404, 1750352, 'Spinach, baby', 'Vitamin B-6', 0.19460000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1750352/nutrients', 'verified'),
(405, 1999630, 'Soy milk, unsweetened, plain, shelf stable', 'Vitamin B-6', 0.05525000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1999630/nutrients', 'verified'),
(406, 2003589, 'Flour, semolina, fine', 'Vitamin B-6', 0.10820000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003589/nutrients', 'verified'),
(407, 2003596, 'Tomato juice, with added ingredients, from concentrate, shelf stable', 'Vitamin B-6', 0.07613000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003596/nutrients', 'verified'),
(408, 2003603, 'Mushroom, beech', 'Vitamin B-6', 0.10540000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003603/nutrients', 'verified'),
(409, 2258588, 'Peppers, bell, green, raw', 'Vitamin B-6', 0.24680000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2258588/nutrients', 'verified'),
(410, 2259796, 'Cheese, feta, whole milk, crumbled', 'Vitamin B-6', 0.03831000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2259796/nutrients', 'verified'),
(411, 2262075, 'Flaxseed, ground', 'Vitamin B-6', 0.39260000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2262075/nutrients', 'verified'),
(412, 2346390, 'Lettuce, leaf, red, raw', 'Vitamin B-6', 0.07413000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346390/nutrients', 'verified'),
(413, 2346397, 'Oats, whole grain, steel cut', 'Vitamin B-6', 0.11890000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346397/nutrients', 'verified'),
(414, 2346404, 'Sweet potatoes, orange flesh, without skin, raw', 'Vitamin B-6', 0.12410000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346404/nutrients', 'verified'),
(415, 2512374, 'Flour, buckwheat', 'Vitamin B-6', 0.16990000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2512374/nutrients', 'verified'),
(416, 2512381, 'Rice, white, long grain, unenriched, raw', 'Vitamin B-6', 0.05788000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2512381/nutrients', 'verified'),
(417, 2710824, 'Avocado, Hass, peeled, raw', 'Vitamin B-6', 0.16740000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2710824/nutrients', 'verified'),
(418, 2710833, 'Mango, Tommy Atkins, peeled, raw', 'Vitamin B-6', 0.07138000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2710833/nutrients', 'verified'),
(419, 2710843, 'Plantains, overripe, raw', 'Vitamin B-6', 0.19580000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2710843/nutrients', 'verified'),
(420, 2747653, 'Beet greens, raw', 'Vitamin B-6', 0.11480000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2747653/nutrients', 'verified'),
(421, 2758975, 'Rhubarb, stalk, raw', 'Vitamin B-6', 0.04488000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2758975/nutrients', 'verified'),
(422, 2758982, 'Baked beans, Original, canned, with pork', 'Vitamin B-6', 0.05607000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2758982/nutrients', 'verified'),
(423, 2758989, 'Peanut butter, Creamy', 'Vitamin B-6', 0.13460000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2758989/nutrients', 'verified'),
(424, 2759004, 'Lunchmeat, chicken breast, sliced', 'Vitamin B-6', 0.23880000, 'mg', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2759004/nutrients', 'verified'),
(425, 321360, 'Tomatoes, grape, raw', 'Folate, total', 10.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/321360/nutrients', 'verified'),
(426, 322892, 'Milk, whole, 3.25% milkfat, with added vitamin D', 'Folate, total', 0.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/322892/nutrients', 'verified'),
(427, 324317, 'Onion rings, breaded, par fried, frozen, prepared, heated in oven', 'Folate, total', 31.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/324317/nutrients', 'verified'),
(428, 325287, 'Grapefruit juice, white, canned or bottled, unsweetened', 'Folate, total', 12.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/325287/nutrients', 'verified'),
(429, 326196, 'Kale, frozen, cooked, boiled, drained, without salt', 'Folate, total', 65.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/326196/nutrients', 'verified'),
(430, 327046, 'Kiwifruit, green, raw', 'Folate, total', 26.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/327046/nutrients', 'verified'),
(431, 327923, 'Lettuce, cos or romaine, raw', 'Folate, total', 50.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/327923/nutrients', 'verified'),
(432, 330415, 'Yogurt, Greek, strawberry, nonfat', 'Folate, total', 20.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/330415/nutrients', 'verified'),
(433, 335240, 'Bread, whole-wheat, commercially prepared', 'Folate, total', 42.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/335240/nutrients', 'verified'),
(434, 746768, 'Figs, dried, uncooked', 'Folate, total', 9.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746768/nutrients', 'verified'),
(435, 746772, 'Milk, lowfat, fluid, 1% milkfat, with added vitamin A and vitamin D', 'Folate, total', 2.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746772/nutrients', 'verified'),
(436, 746781, 'Sausage, pork, chorizo, link or ground, cooked, pan-fried', 'Folate, total', 10.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746781/nutrients', 'verified'),
(437, 748967, 'Eggs, Grade A, Large, egg whole', 'Folate, total', 71.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/748967/nutrients', 'verified'),
(438, 790146, 'Flour, bread, white, enriched, unbleached', 'Folate, total', 145.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/790146/nutrients', 'verified'),
(439, 790774, 'Bananas, overripe, raw', 'Folate, total', 25.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/790774/nutrients', 'verified'),
(440, 1105547, 'Apples, honeycrisp, with skin, raw', 'Folate, total', 0.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1105547/nutrients', 'verified'),
(441, 1750337, 'Soy milk, unsweetened, plain, shelf stable', 'Folate, total', 19.69000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1750337/nutrients', 'verified'),
(442, 1750342, 'Apples, granny smith, with skin, raw', 'Folate, total', 0.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1750342/nutrients', 'verified'),
(443, 1750346, 'Mushrooms, shiitake', 'Folate, total', 32.13000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1750346/nutrients', 'verified'),
(444, 1999626, 'Mushroom, lion\'s mane', 'Folate, total', 29.58000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1999626/nutrients', 'verified'),
(445, 1999630, 'Soy milk, unsweetened, plain, shelf stable', 'Folate, total', 19.69000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1999630/nutrients', 'verified'),
(446, 2003587, 'Flour, spelt, whole grain', 'Folate, total', 38.42000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003587/nutrients', 'verified'),
(447, 2003591, 'Orange juice, no pulp, not fortified, from concentrate, refrigerated', 'Folate, total', 29.85000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003591/nutrients', 'verified'),
(448, 2003596, 'Tomato juice, with added ingredients, from concentrate, shelf stable', 'Folate, total', 18.93000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2003596/nutrients', 'verified'),
(449, 2257046, 'Oat milk, unsweetened, plain, refrigerated', 'Folate, total', 0.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2257046/nutrients', 'verified'),
(450, 2261420, 'Flour, almond', 'Folate, total', 37.83000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2261420/nutrients', 'verified'),
(451, 2262073, 'Sesame butter, creamy', 'Folate, total', 108.40000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2262073/nutrients', 'verified'),
(452, 2685568, 'Squash, summer, green, zucchini, includes skin, raw', 'Folate, total', 71.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2685568/nutrients', 'verified'),
(453, 2685572, 'Cabbage, bok choy, raw', 'Folate, total', 68.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2685572/nutrients', 'verified'),
(454, 2685576, 'Beets, raw', 'Folate, total', 103.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2685576/nutrients', 'verified'),
(455, 2710831, 'Kiwifruit (kiwi), green, peeled, raw', 'Folate, total', 32.85000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2710831/nutrients', 'verified'),
(456, 2727582, 'Tomatillos, dehusked, raw', 'Folate, total', 16.39000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2727582/nutrients', 'verified'),
(457, 2747655, 'Fennel, bulb, raw', 'Folate, total', 37.02000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2747655/nutrients', 'verified'),
(458, 2747662, 'Peppers, poblano, seeded, raw', 'Folate, total', 26.05000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2747662/nutrients', 'verified'),
(459, 2747675, 'Watermelon, seedless, flesh only, raw', 'Folate, total', 11.93000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2747675/nutrients', 'verified'),
(460, 2758983, 'Beans, baked, canned, vegetarian', 'Folate, total', 58.99000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2758983/nutrients', 'verified'),
(461, 2758994, 'Bread, 100% whole wheat, commercial', 'Folate, total', 58.24000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2758994/nutrients', 'verified'),
(462, 2758998, 'Pasta, dry, enriched, spaghetti', 'Folate, total', 229.60000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2758998/nutrients', 'verified'),
(463, 322228, 'Milk, lowfat, fluid, 1% milkfat, with added vitamin A and vitamin D', 'Vitamin B-12', 0.61000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/322228/nutrients', 'verified'),
(464, 322892, 'Milk, whole, 3.25% milkfat, with added vitamin D', 'Vitamin B-12', 0.54000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/322892/nutrients', 'verified'),
(465, 324157, 'Sausage, breakfast sausage, beef, pre-cooked, unprepared', 'Vitamin B-12', 1.13000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/324157/nutrients', 'verified'),
(466, 325198, 'Cheese, pasteurized process, American, vitamin D fortified', 'Vitamin B-12', 1.45000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/325198/nutrients', 'verified'),
(467, 326135, 'Cheese, swiss', 'Vitamin B-12', 3.02000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/326135/nutrients', 'verified'),
(468, 328841, 'Cheese, cottage, lowfat, 2% milkfat', 'Vitamin B-12', 0.42000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/328841/nutrients', 'verified'),
(469, 330137, 'Yogurt, Greek, plain, nonfat', 'Vitamin B-12', 0.70000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/330137/nutrients', 'verified'),
(470, 330869, 'Turkey, ground, 93% lean, 7% fat, pan-broiled crumbles', 'Vitamin B-12', 1.90000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/330869/nutrients', 'verified'),
(471, 332864, 'Sausage, pork, chorizo, link or ground, cooked, pan-fried', 'Vitamin B-12', 1.21000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/332864/nutrients', 'verified'),
(472, 333476, 'Fish, pollock, raw', 'Vitamin B-12', 1.63000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/333476/nutrients', 'verified'),
(473, 334462, 'Restaurant, Chinese, sweet and sour pork', 'Vitamin B-12', 0.19000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/334462/nutrients', 'verified'),
(474, 334897, 'Beef, loin, tenderloin roast, separable lean only, boneless, trimmed to 0\" fat, select, cooked, roasted', 'Vitamin B-12', 4.21000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/334897/nutrients', 'verified'),
(475, 334963, 'Beef, round, top round roast, boneless, separable lean only, trimmed to 0\" fat, select, raw', 'Vitamin B-12', 1.62000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/334963/nutrients', 'verified'),
(476, 746758, 'Beef, loin, tenderloin roast, separable lean only, boneless, trimmed to 0\" fat, select, cooked, roasted', 'Vitamin B-12', 4.21000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746758/nutrients', 'verified'),
(477, 746760, 'Beef, round, eye of round roast, boneless, separable lean only, trimmed to 0\" fat, select, raw', 'Vitamin B-12', 2.06000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746760/nutrients', 'verified'),
(478, 746763, 'Beef, short loin, t-bone steak, bone-in, separable lean only, trimmed to 1/8\" fat, choice, cooked, grilled', 'Vitamin B-12', 1.88000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746763/nutrients', 'verified'),
(479, 746766, 'Cheese, ricotta, whole milk', 'Vitamin B-12', 0.78000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746766/nutrients', 'verified'),
(480, 746774, 'Restaurant, Chinese, sweet and sour pork', 'Vitamin B-12', 0.19000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746774/nutrients', 'verified'),
(481, 746778, 'Milk, reduced fat, fluid, 2% milkfat, with added vitamin A and vitamin D', 'Vitamin B-12', 0.55000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746778/nutrients', 'verified'),
(482, 746781, 'Sausage, pork, chorizo, link or ground, cooked, pan-fried', 'Vitamin B-12', 1.21000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746781/nutrients', 'verified'),
(483, 746783, 'Sausage, turkey, breakfast links, mild, raw', 'Vitamin B-12', 1.20000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/746783/nutrients', 'verified'),
(484, 790508, 'Butter, stick, salted', 'Vitamin B-12', 0.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/790508/nutrients', 'verified');
INSERT INTO `food_nutrient_data` (`food_record_id`, `fdc_id`, `food_name`, `nutrient_name`, `nutrient_amount`, `nutrient_unit`, `serving_basis`, `source_url`, `verification_status`) VALUES
(485, 1750338, 'Almond milk, unsweetened, plain, shelf stable', 'Vitamin B-12', 0.33750000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/1750338/nutrients', 'verified'),
(486, 2257044, 'Soy milk, sweetened, plain, refrigerated', 'Vitamin B-12', 1.32700000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2257044/nutrients', 'verified'),
(487, 2257046, 'Oat milk, unsweetened, plain, refrigerated', 'Vitamin B-12', 0.50640000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2257046/nutrients', 'verified'),
(488, 2346386, 'Cream, heavy', 'Vitamin B-12', 0.00000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2346386/nutrients', 'verified'),
(489, 2684440, 'Fish, salmon, sockeye, wild caught, raw', 'Vitamin B-12', 5.16000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2684440/nutrients', 'verified'),
(490, 2684443, 'Crustaceans, shrimp, farm raised, raw', 'Vitamin B-12', 0.99630000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2684443/nutrients', 'verified'),
(491, 2684445, 'Fish, catfish, farm raised, raw', 'Vitamin B-12', 2.26600000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2684445/nutrients', 'verified'),
(492, 2747652, 'Anchovies, canned in olive oil, with salt, drained', 'Vitamin B-12', 12.65000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2747652/nutrients', 'verified'),
(493, 2747657, 'Lobster, tail only, frozen, wild caught', 'Vitamin B-12', 0.99500000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2747657/nutrients', 'verified'),
(494, 2747666, 'Scallops, bay, Patagonian, frozen, wild caught', 'Vitamin B-12', 0.67000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2747666/nutrients', 'verified'),
(495, 2747669, 'Snapper, frozen, wild caught', 'Vitamin B-12', 1.57100000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2747669/nutrients', 'verified'),
(496, 2747671, 'Squid (calamari), frozen, tubes only', 'Vitamin B-12', 1.12500000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2747671/nutrients', 'verified'),
(497, 2758991, 'Bologna, beef', 'Vitamin B-12', 1.22000000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2758991/nutrients', 'verified'),
(498, 2759001, 'Lunchmeat, turkey, oven roasted, sliced', 'Vitamin B-12', 0.55580000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2759001/nutrients', 'verified'),
(499, 2759004, 'Lunchmeat, chicken breast, sliced', 'Vitamin B-12', 0.11830000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2759004/nutrients', 'verified'),
(500, 2759006, 'Pepperoni, beef and pork, sliced', 'Vitamin B-12', 0.49310000, 'ug', 'per 100 g (Foundation food record; 2026-04-30)', 'https://fdc.nal.usda.gov/food-details/2759006/nutrients', 'verified');

-- --------------------------------------------------------

--
-- Table structure for table `food_recommendations`
--

CREATE TABLE `food_recommendations` (
  `id` int(11) NOT NULL,
  `deficiency_id` int(11) NOT NULL,
  `food_name` varchar(255) DEFAULT NULL,
  `benefits` text NOT NULL,
  `avoid_food` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `food_recommendations`
--

INSERT INTO `food_recommendations` (`id`, `deficiency_id`, `food_name`, `benefits`, `avoid_food`) VALUES
(1, 1, 'Spinach', 'Spinach contains non-heme iron, but the amount per serving and absorption vary. This project record is not matched to an exact food-composition entry, so do not treat it as a concentrated iron source.', 'Avoid excessive tea or coffee immediately after meals.'),
(2, 1, 'Lentils', 'Provide plant-based (non-heme) iron, protein and fiber. Pair with vitamin C-rich foods to support iron absorption.', 'Tea and coffee can reduce absorption of plant-based iron; have them between meals rather than with iron-rich meals.'),
(3, 1, 'Red Meat', 'Provides readily absorbed heme iron, vitamin B12 and protein.', 'Limit excessive portions and processed meats; choose lean, unprocessed options when possible.'),
(4, 1, 'Pumpkin Seeds', 'Provide plant-based iron, protein and magnesium.', 'Avoid if you have a seed allergy; otherwise, use portions that fit your dietary needs.'),
(5, 1, 'Beans', 'Provide plant-based (non-heme) iron, protein and fiber. Pair with vitamin C-rich foods to support iron absorption.', 'Tea and coffee can reduce absorption of plant-based iron; have them between meals rather than with iron-rich meals.'),
(6, 1, 'Broccoli', 'Provides vitamin C, which can support absorption of non-heme iron from foods such as beans and lentils.', 'No general restriction is needed unless you have an allergy or have been given specific dietary advice.'),
(7, 1, 'Beetroot', 'Provides folate, fiber and antioxidants, but is not a concentrated source of iron.', 'Do not rely on beetroot as the primary iron source; include iron-rich foods and follow clinical advice.'),
(8, 1, 'Chicken Liver', 'Provides readily absorbed heme iron, vitamin B12 and folate.', 'Avoid frequent large servings because liver is high in vitamin A; avoid during pregnancy unless your clinician advises otherwise.'),
(9, 12, 'Eggs', 'Cooked egg yolks provide biotin and protein; cooking also makes raw egg-white avidin less of a concern.', 'Avoid raw egg whites; cook eggs thoroughly. People with an egg allergy should avoid eggs.'),
(10, 12, 'Almonds', 'Provide biotin along with unsaturated fats, protein, and vitamin E as part of a varied diet.', 'Avoid if you have a tree-nut allergy; no specific restriction is needed for most people.'),
(11, 12, 'Sweet Potatoes', 'Provide biotin along with fiber and provitamin A carotenoids.', 'No specific restriction is needed for most people unless you have an allergy or clinician-directed dietary restriction.'),
(12, 12, 'Salmon', 'Provides biotin along with protein and omega-3 fats.', 'Avoid if you have a fish allergy; follow local food-safety advice for preparation.'),
(13, 12, 'Spinach', 'Provides a small amount of biotin as part of a varied diet, as well as folate and other nutrients.', 'No specific restriction is needed for most people unless you have an allergy or clinician-directed dietary restriction.'),
(14, 14, 'Plain yogurt', 'Provides calcium and protein; choose a variety that fits your needs.', 'If you have a milk allergy, choose a suitable fortified alternative; lactose-free dairy may still provide calcium.'),
(15, 14, 'Milk or calcium-fortified soy beverage', 'Provides calcium; fortified soy beverages can be a useful option when dairy is not used. Check the label for calcium content.', 'Shake fortified beverages before pouring and check labels, since calcium content varies; follow clinician advice if you have kidney disease.'),
(16, 14, 'Calcium-set tofu', 'Can provide calcium and plant protein; calcium content depends on the coagulant and product label.', 'Check the label because tofu made with other coagulants may contain much less calcium.'),
(17, 14, 'Sardines with edible bones', 'Provide calcium from edible bones as well as protein and vitamin D.', 'Choose lower-sodium options when needed; avoid if you have a fish allergy.'),
(18, 17, 'Cooked oysters', 'A concentrated food source of copper, as well as protein and other minerals.', 'Avoid raw oysters because of foodborne illness risk; if you have Wilson disease or a copper restriction, follow specialist advice.'),
(19, 17, 'Cashews', 'Provide copper along with unsaturated fats and protein.', 'Avoid if you have a tree-nut allergy; people with Wilson disease should follow specialist advice about copper-rich foods.'),
(20, 17, 'Sunflower seeds', 'Provide copper, unsaturated fats, and other minerals.', 'Avoid if you have a seed allergy; people with Wilson disease should follow specialist advice about copper-rich foods.'),
(21, 17, 'Chickpeas', 'Provide copper and plant protein in a versatile legume.', 'No specific restriction is needed for most people; increase fiber-rich foods gradually if they cause digestive discomfort.'),
(22, 13, 'Lentils', 'Provide folate, fiber, and plant protein.', 'No specific restriction is needed for most people; follow medical advice if you take medicines that affect folate.'),
(23, 13, 'Cooked spinach', 'Provides folate as part of a varied diet.', 'No specific restriction is needed for most people unless you have a clinician-directed dietary restriction.'),
(24, 13, 'Asparagus', 'Provides folate and fiber.', 'No specific restriction is needed for most people unless you have an allergy.'),
(25, 13, 'Avocado', 'Provides folate and unsaturated fats.', 'No specific restriction is needed for most people unless you have an allergy.'),
(26, 18, 'Iodized salt', 'A reliable source of iodine when used in place of non-iodized salt; use modest amounts.', 'Do not increase salt intake to obtain iodine. Ask a clinician about iodine intake if you have thyroid disease or are pregnant.'),
(27, 18, 'Cod', 'Provides iodine and protein; iodine content varies by species and source.', 'Avoid if you have a fish allergy; follow clinician guidance for thyroid conditions.'),
(28, 18, 'Milk or yogurt', 'Dairy foods can contribute iodine as well as protein or calcium; levels vary by product and region.', 'Choose a suitable alternative if you have a milk allergy; plant beverages are not necessarily iodine-fortified.'),
(29, 18, 'Eggs', 'Provide iodine and protein; content varies with production and serving size.', 'Avoid if you have an egg allergy; do not use seaweed or iodine supplements as a substitute for clinical advice.'),
(30, 15, 'Pumpkin seeds', 'Provide magnesium, plant protein, and unsaturated fats.', 'Avoid if you have a seed allergy; people with significant kidney disease should ask a clinician before using magnesium supplements.'),
(31, 15, 'Black beans', 'Provide magnesium along with fiber and plant protein.', 'No specific restriction is needed for most people; increase fiber gradually if needed.'),
(32, 15, 'Cooked spinach', 'Provides magnesium and folate as part of a varied diet.', 'No specific restriction is needed for most people unless a clinician has advised otherwise.'),
(33, 15, 'Oats', 'Provide magnesium and whole-grain fiber.', 'Choose certified gluten-free oats if required for celiac disease or gluten sensitivity.'),
(34, 20, 'Baked potato with skin', 'Provides potassium and fiber.', 'If you have kidney disease or take medicines that raise potassium, ask your clinician before increasing potassium-rich foods.'),
(35, 20, 'White beans', 'Provide potassium, plant protein, and fiber.', 'If you have kidney disease or take medicines that raise potassium, seek individualized advice before increasing intake.'),
(36, 20, 'Plain yogurt', 'Provides potassium and protein; amounts vary by product.', 'Choose a suitable alternative for milk allergy; ask a clinician before increasing potassium if you have kidney disease or relevant medicines.'),
(37, 20, 'Banana', 'Provides potassium and carbohydrate in a convenient whole fruit.', 'If you have kidney disease or take medicines that raise potassium, ask your clinician before increasing intake.'),
(38, 19, 'Cooked fish', 'Fish such as tuna can provide selenium and protein; levels vary by species.', 'Follow local advice about fish choices and mercury, especially during pregnancy; avoid if you have a fish allergy.'),
(39, 19, 'Eggs', 'Provide selenium and protein as part of a varied diet.', 'Avoid if you have an egg allergy; no special restriction is needed for most people.'),
(40, 19, 'Chicken', 'Provides selenium and protein.', 'Cook thoroughly and follow food-safety guidance; no specific restriction is needed for most people.'),
(41, 19, 'Whole-grain bread', 'Can contribute selenium, though amounts vary with growing conditions and ingredients.', 'Choose an option that fits any allergy, celiac, or other clinician-directed dietary needs.'),
(42, 4, 'Sweet potato', 'Provides beta-carotene, which the body can convert to vitamin A, along with fiber.', 'No specific restriction is needed for most people; food beta-carotene is not the same as high-dose retinol supplements.'),
(43, 4, 'Carrots', 'Provide beta-carotene, a provitamin A carotenoid.', 'No specific restriction is needed for most people; avoid relying on high-dose vitamin A supplements without clinical advice.'),
(44, 4, 'Cooked spinach', 'Provides provitamin A carotenoids as part of a varied diet.', 'No specific restriction is needed for most people unless a clinician has advised otherwise.'),
(45, 4, 'Eggs', 'Provide preformed vitamin A along with protein and other nutrients.', 'Avoid high-dose retinol supplements and frequent liver intake during pregnancy unless specifically directed by a clinician.'),
(46, 8, 'Pork', 'Provides thiamin and protein.', 'Cook thoroughly and choose lean, minimally processed options when possible.'),
(47, 8, 'Black beans', 'Provide thiamin, fiber, and plant protein.', 'No specific restriction is needed for most people; seek medical care for suspected deficiency rather than relying on food alone.'),
(48, 8, 'Whole-grain bread', 'Whole grains can provide thiamin and fiber.', 'Check labels if you need a specific grain-free or gluten-free diet.'),
(49, 8, 'Thiamin-fortified breakfast cereal', 'Fortified cereals can contribute thiamin; check the nutrition label for amounts.', 'Choose a lower-sugar option where practical; food changes do not replace urgent assessment for severe symptoms.'),
(50, 3, 'Salmon', 'Provides vitamin B12 and protein.', 'Avoid if you have a fish allergy; follow local fish-safety advice.'),
(51, 3, 'Eggs', 'Provide vitamin B12 and protein.', 'Avoid if you have an egg allergy; eggs alone may not correct a confirmed deficiency.'),
(52, 3, 'Milk or yogurt', 'Dairy foods provide vitamin B12 and can contribute protein and calcium.', 'Choose a suitable alternative if you have a milk allergy; most plant beverages need B12 fortification to provide it.'),
(53, 3, 'Vitamin B12-fortified breakfast cereal', 'Fortified cereal can provide B12; check the label and serving size.', 'Unfortified plant foods are not reliable sources of B12; people following vegan diets need a reliable fortified food or clinician-directed supplement.'),
(54, 9, 'Milk or yogurt', 'Dairy foods provide riboflavin (vitamin B2) and other nutrients.', 'Choose a suitable alternative for milk allergy and check whether plant beverages are riboflavin-fortified.'),
(55, 9, 'Eggs', 'Provide riboflavin and protein.', 'Avoid if you have an egg allergy; no other general restriction is needed.'),
(56, 9, 'Mushrooms', 'Some mushroom varieties provide riboflavin and fiber.', 'Cook and store safely; avoid if you have a mushroom allergy or intolerance.'),
(57, 9, 'Riboflavin-fortified cereal', 'Fortified cereal can contribute riboflavin; check the nutrition label.', 'Choose an option that fits your overall dietary needs; a confirmed deficiency may need clinical treatment.'),
(58, 10, 'Chicken', 'Provides niacin (vitamin B3) and protein.', 'Cook thoroughly and choose lean, minimally processed options when possible.'),
(59, 10, 'Tuna', 'Provides niacin and protein.', 'Follow local advice on tuna frequency and mercury, especially during pregnancy; avoid if you have a fish allergy.'),
(60, 10, 'Peanuts', 'Provide niacin along with protein and unsaturated fats.', 'Avoid if you have a peanut allergy; high-dose niacin supplements can cause harm and require medical supervision.'),
(61, 10, 'Brown rice', 'Provides niacin and whole-grain fiber.', 'Choose a suitable grain alternative if required; food sources do not replace care for a confirmed deficiency.'),
(62, 11, 'Chickpeas', 'Provide vitamin B6, fiber, and plant protein.', 'No specific restriction is needed for most people; avoid high-dose B6 supplements unless prescribed.'),
(63, 11, 'Salmon', 'Provides vitamin B6, protein, and omega-3 fats.', 'Avoid if you have a fish allergy; follow local fish-safety advice.'),
(64, 11, 'Potatoes', 'Provide vitamin B6 and carbohydrate as part of a varied meal.', 'No specific restriction is needed for most people unless a clinician has advised otherwise.'),
(65, 11, 'Banana', 'Provides vitamin B6 and carbohydrate as a whole fruit.', 'No specific restriction is needed for most people; avoid prolonged high-dose B6 supplements unless prescribed.'),
(66, 5, 'Red bell pepper', 'Provides vitamin C; eating it raw or lightly cooked can help preserve vitamin C.', 'Avoid if you have an allergy or intolerance; no high-dose supplement is needed unless clinically advised.'),
(67, 5, 'Orange', 'Provides vitamin C and fluid as a whole fruit.', 'If citrus worsens reflux or irritation, choose another vitamin C-rich fruit or vegetable.'),
(68, 5, 'Kiwi', 'Provides vitamin C and fiber.', 'Avoid if you have a kiwi allergy; choose another fruit if it causes oral irritation.'),
(69, 5, 'Broccoli', 'Provides vitamin C and fiber; brief cooking can reduce losses compared with prolonged boiling.', 'No specific restriction is needed for most people unless you have an allergy or clinician-directed restriction.'),
(70, 2, 'Salmon', 'Provides vitamin D and protein; amounts vary by species and serving.', 'Avoid if you have a fish allergy; food alone may not correct a confirmed deficiency.'),
(71, 2, 'Trout', 'Provides vitamin D and protein; amounts vary by source and serving.', 'Avoid if you have a fish allergy; follow local fish-safety advice.'),
(72, 2, 'Vitamin D-fortified milk', 'Fortified milk can contribute vitamin D; check the label for the amount per serving.', 'Choose a suitable alternative for milk allergy and check that plant beverages are fortified.'),
(73, 2, 'Vitamin D-fortified soy beverage', 'A fortified plant beverage can contribute vitamin D; check the label and shake before pouring if directed.', 'Fortification varies by product; do not take high-dose vitamin D supplements without clinical guidance.'),
(74, 6, 'Sunflower seeds', 'Provide vitamin E and unsaturated fats.', 'Avoid if you have a seed allergy; high-dose vitamin E supplements can interact with medicines and should be clinician-directed.'),
(75, 6, 'Almonds', 'Provide vitamin E, fiber, and unsaturated fats.', 'Avoid if you have a tree-nut allergy; high-dose vitamin E supplements can increase bleeding risk.'),
(76, 6, 'Sunflower oil', 'Provides vitamin E; use as one option among varied unsaturated oils.', 'Use appropriate portions and avoid repeatedly heating oil to smoking; avoid if you have a relevant allergy.'),
(77, 6, 'Avocado', 'Provides vitamin E and unsaturated fats.', 'No specific restriction is needed for most people unless you have an allergy or clinician-directed dietary restriction.'),
(78, 7, 'Kale', 'Provides vitamin K1 and other nutrients.', 'If you take warfarin, keep vitamin K intake consistent and coordinate changes with your clinician rather than avoiding these foods.'),
(79, 7, 'Spinach', 'Provides vitamin K1 as part of a varied diet.', 'If you take warfarin, maintain a consistent intake and follow your anticoagulation clinician\'s advice.'),
(80, 7, 'Broccoli', 'Provides vitamin K1 and other nutrients.', 'If you take warfarin, do not make sudden large changes in intake without discussing them with your clinician.'),
(81, 7, 'Canola or soybean oil', 'These oils can contribute vitamin K1; amounts vary by product and serving.', 'If you take warfarin, focus on consistent intake and seek clinician guidance before major dietary changes.'),
(82, 16, 'Cooked oysters', 'Provide zinc; amounts can be high and vary by species and serving.', 'Avoid raw oysters because of foodborne illness risk; avoid if you have a shellfish allergy.'),
(83, 16, 'Beef', 'Provides zinc and protein.', 'Choose lean, unprocessed options and moderate portions; avoid if you have an allergy or dietary restriction.'),
(84, 16, 'Pumpkin seeds', 'Provide zinc, plant protein, and unsaturated fats.', 'Avoid if you have a seed allergy; high-dose zinc supplements can cause copper deficiency.'),
(85, 16, 'Chickpeas', 'Provide zinc, fiber, and plant protein; soaking and thorough cooking can improve meal digestibility.', 'Plant phytates can reduce zinc absorption, so include a varied diet; do not use high-dose zinc supplements without clinical advice.');

-- --------------------------------------------------------

--
-- Table structure for table `food_recommendation_metadata`
--

CREATE TABLE `food_recommendation_metadata` (
  `food_recommendation_id` int(11) NOT NULL,
  `nutrient_name` varchar(100) NOT NULL,
  `source_url` varchar(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `food_recommendation_metadata`
--

INSERT INTO `food_recommendation_metadata` (`food_recommendation_id`, `nutrient_name`, `source_url`) VALUES
(1, 'Iron', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(2, 'Iron', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(3, 'Iron', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(4, 'Iron', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(5, 'Iron', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(6, 'Iron', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(7, 'Iron', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(8, 'Iron', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(9, 'Biotin', 'https://ods.od.nih.gov/factsheets/Biotin-HealthProfessional/'),
(10, 'Biotin', 'https://ods.od.nih.gov/factsheets/Biotin-HealthProfessional/'),
(11, 'Biotin', 'https://ods.od.nih.gov/factsheets/Biotin-HealthProfessional/'),
(12, 'Biotin', 'https://ods.od.nih.gov/factsheets/Biotin-HealthProfessional/'),
(13, 'Biotin', 'https://ods.od.nih.gov/factsheets/Biotin-HealthProfessional/'),
(14, 'Calcium', 'https://ods.od.nih.gov/factsheets/Calcium-HealthProfessional/'),
(15, 'Calcium', 'https://ods.od.nih.gov/factsheets/Calcium-HealthProfessional/'),
(16, 'Calcium', 'https://ods.od.nih.gov/factsheets/Calcium-HealthProfessional/'),
(17, 'Calcium', 'https://ods.od.nih.gov/factsheets/Calcium-HealthProfessional/'),
(18, 'Copper', 'https://ods.od.nih.gov/factsheets/Copper-HealthProfessional/'),
(19, 'Copper', 'https://ods.od.nih.gov/factsheets/Copper-HealthProfessional/'),
(20, 'Copper', 'https://ods.od.nih.gov/factsheets/Copper-HealthProfessional/'),
(21, 'Copper', 'https://ods.od.nih.gov/factsheets/Copper-HealthProfessional/'),
(22, 'Folate', 'https://ods.od.nih.gov/factsheets/Folate-HealthProfessional/'),
(23, 'Folate', 'https://ods.od.nih.gov/factsheets/Folate-HealthProfessional/'),
(24, 'Folate', 'https://ods.od.nih.gov/factsheets/Folate-HealthProfessional/'),
(25, 'Folate', 'https://ods.od.nih.gov/factsheets/Folate-HealthProfessional/'),
(26, 'Iodine', 'https://ods.od.nih.gov/factsheets/Iodine-HealthProfessional/'),
(27, 'Iodine', 'https://ods.od.nih.gov/factsheets/Iodine-HealthProfessional/'),
(28, 'Iodine', 'https://ods.od.nih.gov/factsheets/Iodine-HealthProfessional/'),
(29, 'Iodine', 'https://ods.od.nih.gov/factsheets/Iodine-HealthProfessional/'),
(30, 'Magnesium', 'https://ods.od.nih.gov/factsheets/Magnesium-HealthProfessional/'),
(31, 'Magnesium', 'https://ods.od.nih.gov/factsheets/Magnesium-HealthProfessional/'),
(32, 'Magnesium', 'https://ods.od.nih.gov/factsheets/Magnesium-HealthProfessional/'),
(33, 'Magnesium', 'https://ods.od.nih.gov/factsheets/Magnesium-HealthProfessional/'),
(34, 'Potassium', 'https://ods.od.nih.gov/factsheets/Potassium-HealthProfessional/'),
(35, 'Potassium', 'https://ods.od.nih.gov/factsheets/Potassium-HealthProfessional/'),
(36, 'Potassium', 'https://ods.od.nih.gov/factsheets/Potassium-HealthProfessional/'),
(37, 'Potassium', 'https://ods.od.nih.gov/factsheets/Potassium-HealthProfessional/'),
(38, 'Selenium', 'https://ods.od.nih.gov/factsheets/Selenium-HealthProfessional/'),
(39, 'Selenium', 'https://ods.od.nih.gov/factsheets/Selenium-HealthProfessional/'),
(40, 'Selenium', 'https://ods.od.nih.gov/factsheets/Selenium-HealthProfessional/'),
(41, 'Selenium', 'https://ods.od.nih.gov/factsheets/Selenium-HealthProfessional/'),
(42, 'Vitamin A', 'https://ods.od.nih.gov/factsheets/VitaminA-HealthProfessional/'),
(43, 'Vitamin A', 'https://ods.od.nih.gov/factsheets/VitaminA-HealthProfessional/'),
(44, 'Vitamin A', 'https://ods.od.nih.gov/factsheets/VitaminA-HealthProfessional/'),
(45, 'Vitamin A', 'https://ods.od.nih.gov/factsheets/VitaminA-HealthProfessional/'),
(46, 'Vitamin B1 (thiamin)', 'https://ods.od.nih.gov/factsheets/Thiamin-HealthProfessional/'),
(47, 'Vitamin B1 (thiamin)', 'https://ods.od.nih.gov/factsheets/Thiamin-HealthProfessional/'),
(48, 'Vitamin B1 (thiamin)', 'https://ods.od.nih.gov/factsheets/Thiamin-HealthProfessional/'),
(49, 'Vitamin B1 (thiamin)', 'https://ods.od.nih.gov/factsheets/Thiamin-HealthProfessional/'),
(50, 'Vitamin B12', 'https://ods.od.nih.gov/factsheets/VitaminB12-HealthProfessional/'),
(51, 'Vitamin B12', 'https://ods.od.nih.gov/factsheets/VitaminB12-HealthProfessional/'),
(52, 'Vitamin B12', 'https://ods.od.nih.gov/factsheets/VitaminB12-HealthProfessional/'),
(53, 'Vitamin B12', 'https://ods.od.nih.gov/factsheets/VitaminB12-HealthProfessional/'),
(54, 'Vitamin B2 (riboflavin)', 'https://ods.od.nih.gov/factsheets/Riboflavin-HealthProfessional/'),
(55, 'Vitamin B2 (riboflavin)', 'https://ods.od.nih.gov/factsheets/Riboflavin-HealthProfessional/'),
(56, 'Vitamin B2 (riboflavin)', 'https://ods.od.nih.gov/factsheets/Riboflavin-HealthProfessional/'),
(57, 'Vitamin B2 (riboflavin)', 'https://ods.od.nih.gov/factsheets/Riboflavin-HealthProfessional/'),
(58, 'Vitamin B3 (niacin)', 'https://ods.od.nih.gov/factsheets/Niacin-HealthProfessional/'),
(59, 'Vitamin B3 (niacin)', 'https://ods.od.nih.gov/factsheets/Niacin-HealthProfessional/'),
(60, 'Vitamin B3 (niacin)', 'https://ods.od.nih.gov/factsheets/Niacin-HealthProfessional/'),
(61, 'Vitamin B3 (niacin)', 'https://ods.od.nih.gov/factsheets/Niacin-HealthProfessional/'),
(62, 'Vitamin B6', 'https://ods.od.nih.gov/factsheets/VitaminB6-HealthProfessional/'),
(63, 'Vitamin B6', 'https://ods.od.nih.gov/factsheets/VitaminB6-HealthProfessional/'),
(64, 'Vitamin B6', 'https://ods.od.nih.gov/factsheets/VitaminB6-HealthProfessional/'),
(65, 'Vitamin B6', 'https://ods.od.nih.gov/factsheets/VitaminB6-HealthProfessional/'),
(66, 'Vitamin C', 'https://ods.od.nih.gov/factsheets/VitaminC-HealthProfessional/'),
(67, 'Vitamin C', 'https://ods.od.nih.gov/factsheets/VitaminC-HealthProfessional/'),
(68, 'Vitamin C', 'https://ods.od.nih.gov/factsheets/VitaminC-HealthProfessional/'),
(69, 'Vitamin C', 'https://ods.od.nih.gov/factsheets/VitaminC-HealthProfessional/'),
(70, 'Vitamin D', 'https://ods.od.nih.gov/factsheets/VitaminD-HealthProfessional/'),
(71, 'Vitamin D', 'https://ods.od.nih.gov/factsheets/VitaminD-HealthProfessional/'),
(72, 'Vitamin D', 'https://ods.od.nih.gov/factsheets/VitaminD-HealthProfessional/'),
(73, 'Vitamin D', 'https://ods.od.nih.gov/factsheets/VitaminD-HealthProfessional/'),
(74, 'Vitamin E', 'https://ods.od.nih.gov/factsheets/VitaminE-HealthProfessional/'),
(75, 'Vitamin E', 'https://ods.od.nih.gov/factsheets/VitaminE-HealthProfessional/'),
(76, 'Vitamin E', 'https://ods.od.nih.gov/factsheets/VitaminE-HealthProfessional/'),
(77, 'Vitamin E', 'https://ods.od.nih.gov/factsheets/VitaminE-HealthProfessional/'),
(78, 'Vitamin K', 'https://ods.od.nih.gov/factsheets/VitaminK-HealthProfessional/'),
(79, 'Vitamin K', 'https://ods.od.nih.gov/factsheets/VitaminK-HealthProfessional/'),
(80, 'Vitamin K', 'https://ods.od.nih.gov/factsheets/VitaminK-HealthProfessional/'),
(81, 'Vitamin K', 'https://ods.od.nih.gov/factsheets/VitaminK-HealthProfessional/'),
(82, 'Zinc', 'https://ods.od.nih.gov/factsheets/Zinc-HealthProfessional/'),
(83, 'Zinc', 'https://ods.od.nih.gov/factsheets/Zinc-HealthProfessional/'),
(84, 'Zinc', 'https://ods.od.nih.gov/factsheets/Zinc-HealthProfessional/'),
(85, 'Zinc', 'https://ods.od.nih.gov/factsheets/Zinc-HealthProfessional/');

-- --------------------------------------------------------

--
-- Table structure for table `gene_associations`
--

CREATE TABLE `gene_associations` (
  `id` int(11) NOT NULL,
  `deficiency_id` int(11) NOT NULL,
  `gene_symbol` varchar(30) NOT NULL,
  `gene_name` varchar(255) DEFAULT NULL,
  `ncbi_gene_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gene_associations`
--

INSERT INTO `gene_associations` (`id`, `deficiency_id`, `gene_symbol`, `gene_name`, `ncbi_gene_id`) VALUES
(1, 1, 'HFE', 'Homeostatic Iron Regulator', 3077),
(2, 1, 'TF', 'Transferrin', 7018),
(3, 1, 'TFR2', 'Transferrin Receptor 2', 7036),
(4, 1, 'SLC40A1', 'Ferroportin', 30061),
(5, 1, 'HAMP', 'Hepcidin Antimicrobial Peptide', 57817),
(6, 2, 'VDR', 'vitamin D receptor', 7421),
(7, 2, 'CYP27B1', 'cytochrome P450 family 27 subfamily B member 1', 1594),
(8, 2, 'CYP24A1', 'cytochrome P450 family 24 subfamily A member 1', 1591),
(9, 2, 'GC', 'group-specific component (vitamin D-binding protein)', 2638),
(10, 3, 'TCN2', 'transcobalamin 2', 6948),
(11, 3, 'CBLIF', 'cobalamin binding intrinsic factor (GIF)', 2694),
(12, 3, 'CUBN', 'cubilin', 8029),
(13, 3, 'MMACHC', 'methylmalonic aciduria and homocystinuria type C protein', 25974),
(14, 15, 'TRPM6', 'transient receptor potential cation channel subfamily M member 6', 140803),
(15, 15, 'CNNM2', 'cyclin and CBS domain divalent metal cation transport mediator 2', 54805),
(16, 15, 'FXYD2', 'FXYD domain containing ion transport regulator 2', 486),
(21, 4, 'RBP4', 'retinol binding protein 4', 5950),
(22, 4, 'STRA6', 'signaling receptor and transporter of retinol STRA6', 64220),
(23, 4, 'BCO1', 'beta-carotene oxygenase 1', 53630),
(24, 5, 'SLC23A1', 'solute carrier family 23 member 1', 9963),
(25, 5, 'SLC23A2', 'solute carrier family 23 member 2', 9962),
(26, 6, 'TTPA', 'alpha tocopherol transfer protein', 7274),
(27, 6, 'APOB', 'apolipoprotein B', 338),
(28, 7, 'VKORC1', 'vitamin K epoxide reductase complex subunit 1', 79001),
(29, 7, 'GGCX', 'gamma-glutamyl carboxylase', 2677),
(30, 7, 'CYP4F2', 'cytochrome P450 family 4 subfamily F member 2', 8529),
(31, 8, 'SLC19A2', 'solute carrier family 19 member 2', 10560),
(32, 8, 'SLC19A3', 'solute carrier family 19 member 3', 80704),
(33, 8, 'TPK1', 'thiamin pyrophosphokinase 1', 27010),
(34, 9, 'SLC52A1', 'solute carrier family 52 member 1', 55065),
(35, 9, 'SLC52A2', 'solute carrier family 52 member 2', 79581),
(36, 9, 'RFK', 'riboflavin kinase', 55312),
(37, 9, 'FLAD1', 'flavin adenine dinucleotide synthetase 1', 80308),
(38, 10, 'NAPRT', 'nicotinate phosphoribosyltransferase', 93100),
(39, 10, 'QPRT', 'quinolinate phosphoribosyltransferase', 23475),
(40, 10, 'NMNAT1', 'nicotinamide nucleotide adenylyltransferase 1', 64802),
(41, 10, 'NADSYN1', 'NAD synthetase 1', 55191),
(42, 11, 'PDXK', 'pyridoxal kinase', 8566),
(43, 11, 'PNPO', 'pyridoxamine 5-prime phosphate oxidase', 55163),
(44, 11, 'PLPBP', 'pyridoxal phosphate binding protein', 11212),
(45, 11, 'ALPL', 'alkaline phosphatase, biomineralization associated', 249),
(46, 12, 'SLC5A6', 'solute carrier family 5 member 6', 8884),
(47, 12, 'BTD', 'biotinidase', 686),
(48, 12, 'HLCS', 'holocarboxylase synthetase', 3141),
(49, 13, 'SLC19A1', 'solute carrier family 19 member 1', 6573),
(50, 13, 'DHFR', 'dihydrofolate reductase', 1719),
(51, 13, 'MTHFR', 'methylenetetrahydrofolate reductase', 4524),
(52, 14, 'TRPV6', 'transient receptor potential cation channel subfamily V member 6', 55503),
(53, 14, 'CASR', 'calcium sensing receptor', 846),
(54, 14, 'VDR', 'vitamin D receptor', 7421),
(55, 15, 'SLC41A1', 'solute carrier family 41 member 1', 254428),
(56, 16, 'SLC39A4', 'solute carrier family 39 member 4', 55630),
(57, 16, 'SLC30A1', 'solute carrier family 30 member 1', 7779),
(58, 16, 'SLC39A8', 'solute carrier family 39 member 8', 64116),
(59, 17, 'ATP7A', 'ATPase copper transporting alpha', 538),
(60, 17, 'ATP7B', 'ATPase copper transporting beta', 540),
(61, 17, 'SLC31A1', 'solute carrier family 31 member 1', 1317),
(62, 17, 'CP', 'ceruloplasmin', 1356),
(63, 18, 'SLC5A5', 'solute carrier family 5 member 5', 6528),
(64, 18, 'TPO', 'thyroid peroxidase', 7173),
(65, 18, 'TG', 'thyroglobulin', 7038),
(66, 18, 'IYD', 'iodotyrosine deiodinase 1', 389434),
(67, 19, 'SELENOP', 'selenoprotein P', 6414),
(68, 19, 'GPX1', 'glutathione peroxidase 1', 2876),
(69, 19, 'SEPSECS', 'O-phosphoserine tRNA:Sec (selenocysteine) tRNA synthase', 51091),
(70, 20, 'ATP1A1', 'ATPase Na+/K+ transporting subunit alpha 1', 476),
(71, 20, 'KCNJ1', 'potassium inwardly rectifying channel subfamily J member 1', 3758),
(72, 20, 'SLC12A1', 'solute carrier family 12 member 1', 6557);

-- --------------------------------------------------------

--
-- Table structure for table `gene_association_metadata`
--

CREATE TABLE `gene_association_metadata` (
  `association_id` int(11) NOT NULL,
  `association_description` text NOT NULL,
  `source_url` varchar(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `gene_association_metadata`
--

INSERT INTO `gene_association_metadata` (`association_id`, `association_description`, `source_url`) VALUES
(1, 'Participates in iron sensing and regulation; variation can affect iron homeostasis, but the association does not establish nutritional deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/3077'),
(2, 'Encodes transferrin, which transports iron in blood; this function is relevant to iron physiology but does not show that low dietary iron is gene-caused.', 'https://www.ncbi.nlm.nih.gov/gene/7018'),
(3, 'Encodes transferrin receptor 2, involved in iron sensing and regulation of hepcidin; this is a biological pathway association, not a diagnosis.', 'https://www.ncbi.nlm.nih.gov/gene/7036'),
(4, 'Encodes ferroportin, a cellular iron exporter involved in iron transport; the association is mechanistic and not a diagnosis.', 'https://www.ncbi.nlm.nih.gov/gene/30061'),
(5, 'Encodes hepcidin, a hormone that regulates systemic iron availability and iron export; this is a biological iron-homeostasis relationship, not proof that dietary iron deficiency is caused by this gene.', 'https://www.ncbi.nlm.nih.gov/gene/57817'),
(6, 'Encodes the vitamin D receptor, a ligand-activated transcription factor involved in mineral metabolism. This biological role is not evidence that the gene causes dietary deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/7421'),
(7, 'Encodes the enzyme that activates vitamin D by 1-alpha hydroxylation. This is a vitamin D metabolism relationship, not a diagnosis.', 'https://www.ncbi.nlm.nih.gov/gene/1594'),
(8, 'Encodes an enzyme that initiates degradation of active vitamin D metabolites. This functional relationship does not establish individual vitamin D status.', 'https://www.ncbi.nlm.nih.gov/gene/1591'),
(9, 'Encodes vitamin D-binding protein, which transports vitamin D metabolites in circulation. This function does not establish deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/2638'),
(10, 'Encodes transcobalamin, which binds circulating cobalamin and mediates its delivery to cells. This biological role does not establish nutritional deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/6948'),
(11, 'Encodes gastric intrinsic factor, required for normal vitamin B12 absorption. This is a biological absorption relationship, not an individual diagnosis.', 'https://www.ncbi.nlm.nih.gov/gene/2694'),
(12, 'Encodes cubilin, part of the intestinal intrinsic factor-cobalamin receptor involved in vitamin B12 uptake. This association does not determine an individual\'s status.', 'https://www.ncbi.nlm.nih.gov/gene/8029'),
(13, 'NCBI notes that the exact function is not fully known and proposes a role in cobalamin binding or intracellular trafficking. Its association with inherited cblC disorders is distinct from dietary vitamin B12 deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/25974'),
(14, 'Encodes an ion channel/kinase involved in epithelial magnesium transport in the intestine and kidney. This mechanism is not a test of the assessed person\'s magnesium status.', 'https://www.ncbi.nlm.nih.gov/gene/140803'),
(15, 'Encodes a divalent metal transport mediator associated with magnesium handling. This molecular context does not establish nutritional deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/54805'),
(16, 'NCBI reports that FXYD2 variants are associated with inherited renal hypomagnesemia. That genetic disorder association is distinct from dietary magnesium deficiency and does not indicate the user\'s status.', 'https://www.ncbi.nlm.nih.gov/gene/486'),
(21, 'Encodes the principal plasma carrier of retinol; this transport role provides vitamin A context and does not establish deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/5950'),
(22, 'Encodes a receptor that mediates cellular uptake of retinol bound to retinol-binding protein; this function does not diagnose vitamin A status.', 'https://www.ncbi.nlm.nih.gov/gene/64220'),
(23, 'Encodes an enzyme that converts provitamin A carotenoids to retinal; this metabolic role is not evidence of an individual deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/53630'),
(24, 'Encodes the sodium-dependent vitamin C transporter involved in intestinal and renal ascorbate handling; this function does not diagnose vitamin C deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/9963'),
(25, 'Encodes a sodium-dependent vitamin C transporter involved in cellular ascorbate uptake; this function does not diagnose vitamin C deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/9962'),
(26, 'Encodes alpha-tocopherol transfer protein, which helps maintain and distribute alpha-tocopherol; this role does not establish vitamin E status.', 'https://www.ncbi.nlm.nih.gov/gene/7274'),
(27, 'Encodes a structural component of lipoproteins that transport dietary lipids, including fat-soluble nutrients; this is transport context, not a deficiency marker.', 'https://www.ncbi.nlm.nih.gov/gene/338'),
(28, 'Encodes vitamin K epoxide reductase, which recycles vitamin K in the gamma-carboxylation cycle; this role does not diagnose vitamin K deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/79001'),
(29, 'Encodes gamma-glutamyl carboxylase, which uses reduced vitamin K to modify vitamin-K-dependent proteins; this role does not establish nutrient status.', 'https://www.ncbi.nlm.nih.gov/gene/2677'),
(30, 'Encodes an enzyme that participates in vitamin K catabolism; this metabolic context does not establish vitamin K deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/8529'),
(31, 'Encodes a thiamin transporter involved in cellular uptake; transport biology is not a test for dietary thiamin deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/10560'),
(32, 'Encodes a second thiamin transporter involved in cellular uptake; transport biology is not a test for dietary thiamin deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/80704'),
(33, 'Encodes thiamin pyrophosphokinase, which converts thiamin to the active cofactor thiamin diphosphate; this role does not diagnose deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/27010'),
(34, 'Encodes a riboflavin transporter involved in vitamin B2 uptake; this function does not establish an individual\'s status.', 'https://www.ncbi.nlm.nih.gov/gene/55065'),
(35, 'Encodes a riboflavin transporter involved in vitamin B2 uptake; this function does not establish an individual\'s status.', 'https://www.ncbi.nlm.nih.gov/gene/79581'),
(36, 'Encodes riboflavin kinase, which phosphorylates riboflavin to form FMN; this biochemical function does not diagnose deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/55312'),
(37, 'Encodes FAD synthase, which converts FMN to FAD; this biochemical function does not diagnose deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/80308'),
(38, 'Encodes nicotinate phosphoribosyltransferase in the Preiss-Handler route of NAD synthesis; this pathway context does not diagnose niacin deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/93100'),
(39, 'Encodes quinolinate phosphoribosyltransferase in de novo NAD synthesis from tryptophan; this function does not establish dietary niacin status.', 'https://www.ncbi.nlm.nih.gov/gene/23475'),
(40, 'Encodes an enzyme that synthesizes NAD from nicotinamide mononucleotide or nicotinic acid mononucleotide; this role does not diagnose niacin deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/64802'),
(41, 'Encodes NAD synthetase, which catalyzes a final step in NAD biosynthesis; this role does not establish dietary niacin status.', 'https://www.ncbi.nlm.nih.gov/gene/55191'),
(42, 'Encodes pyridoxal kinase, which phosphorylates vitamin B6 vitamers in the PLP cofactor pathway; this context is not a deficiency diagnosis.', 'https://www.ncbi.nlm.nih.gov/gene/8566'),
(43, 'Encodes pyridoxine-5-prime-phosphate oxidase, which forms active pyridoxal phosphate; this function does not establish vitamin B6 status.', 'https://www.ncbi.nlm.nih.gov/gene/55163'),
(44, 'Encodes a protein involved in intracellular pyridoxal phosphate homeostasis; this molecular role does not diagnose dietary deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/11212'),
(45, 'Encodes tissue-nonspecific alkaline phosphatase, which can hydrolyze pyridoxal phosphate; its inclusion is biochemical context, not a vitamin B6 test.', 'https://www.ncbi.nlm.nih.gov/gene/249'),
(46, 'Encodes the sodium-dependent multivitamin transporter that transports biotin as well as other substrates; this function does not establish biotin status.', 'https://www.ncbi.nlm.nih.gov/gene/8884'),
(47, 'Encodes biotinidase, which releases and recycles biotin from biocytin and biotinylated peptides; this role does not diagnose nutritional deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/686'),
(48, 'Encodes holocarboxylase synthetase, which attaches biotin to carboxylase enzymes; this role does not establish individual biotin status.', 'https://www.ncbi.nlm.nih.gov/gene/3141'),
(49, 'Encodes the reduced folate carrier involved in cellular folate transport; this function does not diagnose folate deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/6573'),
(50, 'Encodes dihydrofolate reductase, which regenerates tetrahydrofolate for one-carbon metabolism; this role does not establish folate status.', 'https://www.ncbi.nlm.nih.gov/gene/1719'),
(51, 'Encodes an enzyme in folate-dependent one-carbon metabolism; its inclusion describes pathway biology and is not a genetic test or deficiency diagnosis.', 'https://www.ncbi.nlm.nih.gov/gene/4524'),
(52, 'Encodes an epithelial calcium channel involved in intestinal calcium absorption; this function does not determine dietary calcium status.', 'https://www.ncbi.nlm.nih.gov/gene/55503'),
(53, 'Encodes the calcium-sensing receptor that helps regulate calcium homeostasis; this role does not diagnose dietary deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/846'),
(54, 'Encodes the vitamin D receptor, which regulates gene expression including pathways involved in calcium absorption; this is biological context only.', 'https://www.ncbi.nlm.nih.gov/gene/7421'),
(55, 'Encodes a magnesium transporter implicated in cellular magnesium handling; this function does not establish an individual\'s magnesium status.', 'https://www.ncbi.nlm.nih.gov/gene/254428'),
(56, 'Encodes ZIP4, a zinc importer important for intestinal zinc absorption; this role does not diagnose zinc deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/55630'),
(57, 'Encodes a zinc exporter involved in cellular zinc homeostasis; this role does not diagnose dietary zinc deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/7779'),
(58, 'Encodes a metal-ion importer with transport activity for zinc and other divalent metals; this function does not establish zinc status.', 'https://www.ncbi.nlm.nih.gov/gene/64116'),
(59, 'Encodes a copper-transporting ATPase involved in copper distribution; inherited disorders involving this protein are distinct from dietary copper deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/538'),
(60, 'Encodes a copper-transporting ATPase involved in hepatic copper handling; this role does not diagnose nutritional copper deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/540'),
(61, 'Encodes the high-affinity copper importer CTR1; this function is molecular context and does not determine an individual\'s copper status.', 'https://www.ncbi.nlm.nih.gov/gene/1317'),
(62, 'Encodes ceruloplasmin, a copper-containing ferroxidase in plasma; its function is not by itself evidence of dietary copper deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/1356'),
(63, 'Encodes the sodium/iodide symporter that concentrates iodide in thyroid cells; this function does not diagnose iodine deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/6528'),
(64, 'Encodes thyroid peroxidase, which catalyzes iodination and coupling reactions in thyroid hormone synthesis; this role does not establish iodine status.', 'https://www.ncbi.nlm.nih.gov/gene/7173'),
(65, 'Encodes thyroglobulin, the protein scaffold and precursor for thyroid hormone synthesis; this function does not diagnose iodine deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/7038'),
(66, 'Encodes iodotyrosine deiodinase, which recycles iodide from iodinated tyrosines; this function does not establish dietary iodine status.', 'https://www.ncbi.nlm.nih.gov/gene/389434'),
(67, 'Encodes selenoprotein P, a selenium-containing protein involved in selenium transport; this function does not diagnose selenium deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/6414'),
(68, 'Encodes a selenium-dependent glutathione peroxidase involved in peroxide reduction; this pathway role does not establish selenium status.', 'https://www.ncbi.nlm.nih.gov/gene/2876'),
(69, 'Encodes an enzyme required for selenocysteine synthesis on its tRNA during selenoprotein production; this is not a dietary deficiency test.', 'https://www.ncbi.nlm.nih.gov/gene/51091'),
(70, 'Encodes a sodium/potassium pump subunit that maintains transmembrane ion gradients; this role does not diagnose dietary potassium deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/476'),
(71, 'Encodes the renal ROMK potassium channel involved in renal potassium handling; this molecular context does not establish individual potassium status.', 'https://www.ncbi.nlm.nih.gov/gene/3758'),
(72, 'Encodes a renal sodium-potassium-chloride cotransporter involved in electrolyte handling; this function does not diagnose dietary potassium deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/6557');

-- --------------------------------------------------------

--
-- Table structure for table `lifestyle_factors`
--

CREATE TABLE `lifestyle_factors` (
  `id` int(11) NOT NULL,
  `deficiency_id` int(11) DEFAULT NULL,
  `factor_name` varchar(100) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lifestyle_factors`
--

INSERT INTO `lifestyle_factors` (`id`, `deficiency_id`, `factor_name`, `weight`) VALUES
(1, 1, 'Vegetarian Diet', 3),
(2, 1, 'Heavy Menstrual Blood Loss', 5),
(3, 1, 'Frequent Blood Donation', 4),
(4, 1, 'Low Iron Intake', 5);

-- --------------------------------------------------------

--
-- Table structure for table `lifestyle_recommendations`
--

CREATE TABLE `lifestyle_recommendations` (
  `id` int(11) NOT NULL,
  `deficiency_id` int(11) DEFAULT NULL,
  `recommendation_category` varchar(80) NOT NULL,
  `recommendation_text` text NOT NULL,
  `source_url` varchar(2048) NOT NULL DEFAULT '',
  `verification_status` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lifestyle_recommendations`
--

INSERT INTO `lifestyle_recommendations` (`id`, `deficiency_id`, `recommendation_category`, `recommendation_text`, `source_url`, `verification_status`, `active`) VALUES
(1, NULL, 'Diet', 'Choose a varied diet that includes foods containing the relevant nutrient; individual needs differ.', '', 'General non-personalized education; not a treatment recommendation.', 1),
(2, NULL, 'Hydration', 'Maintain hydration in a way that fits your health needs; follow clinician advice if you have a fluid restriction.', '', 'General non-personalized education; not individualized medical advice.', 1),
(3, NULL, 'Sleep and activity', 'Aim for regular sleep and physical activity appropriate to your abilities and health circumstances.', '', 'General non-personalized education; not individualized medical advice.', 1),
(4, NULL, 'Professional support', 'Discuss persistent symptoms, supplements, or treatment decisions with a qualified healthcare professional.', '', 'General safety guidance; this assessment cannot diagnose a deficiency.', 1);

-- --------------------------------------------------------

--
-- Table structure for table `pathway_associations`
--

CREATE TABLE `pathway_associations` (
  `id` int(11) NOT NULL,
  `deficiency_id` int(11) NOT NULL,
  `pathway_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pathway_associations`
--

INSERT INTO `pathway_associations` (`id`, `deficiency_id`, `pathway_name`) VALUES
(1, 1, 'Iron Homeostasis'),
(2, 1, 'HIF-1 Signaling Pathway'),
(3, 1, 'Erythropoiesis'),
(4, 1, 'Iron uptake and transport'),
(5, 2, 'Vitamin D (calciferol) metabolism'),
(6, 3, 'Cobalamin (Cbl, vitamin B12) transport and metabolism'),
(7, 6, 'Vitamin E transport'),
(8, 7, 'Metabolism of vitamin K'),
(9, 13, 'Metabolism of folate and pterines'),
(12, 4, 'Retinoid metabolism and transport'),
(13, 5, 'Vitamin C (ascorbate) metabolism'),
(14, 8, 'Vitamin B1 (thiamin) metabolism'),
(15, 9, 'Vitamin B2 (riboflavin) metabolism'),
(16, 10, 'Metabolism of water-soluble vitamins and cofactors'),
(17, 11, 'Vitamin B6 activation to pyridoxal phosphate'),
(18, 12, 'Biotin transport and metabolism'),
(19, 14, 'Mitochondrial calcium ion transport'),
(20, 15, 'Metal ion SLC transporters'),
(21, 16, 'Zinc transporters'),
(22, 17, 'Metal ion SLC transporters'),
(23, 18, 'Regulation of thyroid hormone activity'),
(24, 19, 'Selenoamino acid metabolism'),
(25, 20, 'Potassium transport channels');

-- --------------------------------------------------------

--
-- Table structure for table `pathway_association_citations`
--

CREATE TABLE `pathway_association_citations` (
  `id` int(11) NOT NULL,
  `pathway_association_id` int(11) NOT NULL,
  `pmid` varchar(30) NOT NULL,
  `citation_title` varchar(512) NOT NULL,
  `source_url` varchar(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pathway_association_citations`
--

INSERT INTO `pathway_association_citations` (`id`, `pathway_association_id`, `pmid`, `citation_title`, `source_url`) VALUES
(1, 4, '20495089', 'Mitochondrial iron trafficking and the integration of iron metabolism between the mitochondrion and cytosol', 'https://pubmed.ncbi.nlm.nih.gov/20495089/'),
(2, 4, '19381358', 'A general map of iron metabolism and tissue-specific subnetworks', 'https://pubmed.ncbi.nlm.nih.gov/19381358/'),
(3, 4, '18259769', 'Lysosomes in iron metabolism, ageing and apoptosis', 'https://pubmed.ncbi.nlm.nih.gov/18259769/'),
(4, 5, '26681795', 'Vitamin D: Metabolism, Molecular Mechanism of Action, and Pleiotropic Effects', 'https://pubmed.ncbi.nlm.nih.gov/26681795/'),
(5, 6, '22547309', 'Vitamin B12 transport from food to the body\'s cells--a sophisticated, multistep pathway', 'https://pubmed.ncbi.nlm.nih.gov/22547309/'),
(6, 6, '21114891', 'Genetic disorders of vitamin B12 metabolism: eight complementation groups--eight genes', 'https://pubmed.ncbi.nlm.nih.gov/21114891/'),
(7, 6, '33797888', 'Redox-Linked Coordination Chemistry Directs Vitamin B12 Trafficking', 'https://pubmed.ncbi.nlm.nih.gov/33797888/'),
(8, 7, '26981194', 'Complexity of vitamin E metabolism', 'https://pubmed.ncbi.nlm.nih.gov/26981194/'),
(9, 8, '9845520', 'A missense mutation in gamma-glutamyl carboxylase gene causes combined deficiency of all vitamin K-dependent blood coagulation factors', 'https://pubmed.ncbi.nlm.nih.gov/9845520/'),
(10, 9, '11001804', 'Folic acid: nutritional biochemistry, molecular biology, and role in disease processes', 'https://pubmed.ncbi.nlm.nih.gov/11001804/');

-- --------------------------------------------------------

--
-- Table structure for table `pathway_association_metadata`
--

CREATE TABLE `pathway_association_metadata` (
  `association_id` int(11) NOT NULL,
  `pathway_id` varchar(100) NOT NULL DEFAULT '',
  `pathway_description` text NOT NULL,
  `source_url` varchar(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pathway_association_metadata`
--

INSERT INTO `pathway_association_metadata` (`association_id`, `pathway_id`, `pathway_description`, `source_url`) VALUES
(1, '', 'Biological process label exported from the existing application database. Exact Reactome pathway correspondence and identifier have not been independently established.', ''),
(2, '', 'Pathway label exported from the existing application database. Exact Reactome pathway correspondence and identifier have not been independently established.', ''),
(3, '', 'Biological process label exported from the existing application database. Exact Reactome pathway correspondence and identifier have not been independently established.', ''),
(4, 'R-HSA-917937', 'Reactome describes transferrin-mediated iron transport between cells and additional routes for cellular iron uptake and export. This is biological context, not evidence that this assessment has detected iron deficiency.', 'https://reactome.org/content/detail/R-HSA-917937'),
(5, 'R-HSA-196791', 'Reactome describes vitamin D production, transport, activation, and inactivation, including its role in calcium metabolism. The pathway does not establish the assessed person\'s vitamin D status.', 'https://reactome.org/content/detail/R-HSA-196791'),
(6, 'R-HSA-196741', 'Reactome describes cobalamin transport and intracellular metabolism. This pathway is relevant to vitamin B12 biology but does not diagnose deficiency.', 'https://reactome.org/content/detail/R-HSA-196741'),
(7, 'R-HSA-8877627', 'Reactome describes transport of alpha-tocopherol by its intracellular carrier proteins. This is a pathway-level reference, not evidence of an individual deficiency.', 'https://reactome.org/content/detail/R-HSA-8877627'),
(8, 'R-HSA-6806664', 'Reactome describes vitamin K metabolism and its cofactor role in gamma-carboxylation. This does not establish an individual\'s vitamin K status.', 'https://reactome.org/content/detail/R-HSA-6806664'),
(9, 'R-HSA-196757', 'Reactome describes folate transport and reactions that generate reduced folates and one-carbon derivatives. This pathway does not diagnose folate deficiency.', 'https://reactome.org/content/detail/R-HSA-196757'),
(12, 'R-HSA-975634', 'Reactome describes dietary vitamin A uptake, retinoid transport, and metabolism. This pathway is biological context and does not establish an individual\'s vitamin A status.', 'https://reactome.org/content/detail/R-HSA-975634'),
(13, 'R-HSA-196836', 'Reactome describes cellular ascorbate uptake, recycling, and cofactor functions. Humans do not synthesize vitamin C; this pathway does not diagnose deficiency.', 'https://reactome.org/content/detail/R-HSA-196836'),
(14, 'R-HSA-196819', 'Reactome describes thiamin uptake and conversion to thiamin diphosphate, a cofactor in energy metabolism. This is pathway context, not a deficiency test.', 'https://reactome.org/content/detail/R-HSA-196819'),
(15, 'R-HSA-196843', 'Reactome describes riboflavin metabolism and formation of FMN and FAD cofactors. This pathway does not establish an individual\'s vitamin B2 status.', 'https://reactome.org/content/detail/R-HSA-196843'),
(16, 'R-HSA-196849', 'Reactome includes water-soluble vitamin metabolism, including niacin-related NAD synthesis. This broad pathway provides context and does not diagnose niacin deficiency.', 'https://reactome.org/content/detail/R-HSA-196849'),
(17, 'R-HSA-964975', 'Reactome describes activation and salvage of vitamin B6 vitamers to pyridoxal phosphate. This pathway does not establish an individual\'s vitamin B6 status.', 'https://reactome.org/content/detail/R-HSA-964975'),
(18, 'R-HSA-196780', 'Reactome describes biotin uptake, intracellular use, and salvage. This pathway provides biological context and does not diagnose deficiency.', 'https://reactome.org/content/detail/R-HSA-196780'),
(19, 'R-HSA-8949215', 'Reactome describes calcium transport into and out of mitochondria. This is cellular calcium-handling context, not a measure of dietary calcium status.', 'https://reactome.org/content/detail/R-HSA-8949215'),
(20, 'R-HSA-425410', 'Reactome describes metal-ion transport by SLC transporter families, including SLC41 proteins involved in magnesium transport. The pathway is not a diagnostic measure of magnesium status.', 'https://reactome.org/content/detail/R-HSA-425410'),
(21, 'R-HSA-435354', 'Reactome describes SLC39 zinc importers and SLC30 zinc exporters that coordinate cellular zinc homeostasis. This pathway does not diagnose dietary zinc deficiency.', 'https://reactome.org/content/detail/R-HSA-435354'),
(22, 'R-HSA-425410', 'Reactome describes metal-ion transport by SLC families including SLC31 copper transporters. This pathway provides molecular context and does not establish copper status.', 'https://reactome.org/content/detail/R-HSA-425410'),
(23, 'R-HSA-350864', 'Reactome describes thyroid hormone production and feedback regulation involving iodine and thyroglobulin. This pathway does not diagnose iodine deficiency.', 'https://reactome.org/content/detail/R-HSA-350864'),
(24, 'R-HSA-2408522', 'Reactome describes dietary selenium processing, selenocysteine formation, and selenium utilization. This pathway does not establish an individual\'s selenium status.', 'https://reactome.org/content/detail/R-HSA-2408522'),
(25, 'R-HSA-1296067', 'Reactome describes inwardly rectifying potassium channels involved in renal tubular potassium transport. This is biological context, not a measure of dietary potassium status.', 'https://reactome.org/content/detail/R-HSA-1296067');

-- --------------------------------------------------------

--
-- Table structure for table `protein_associations`
--

CREATE TABLE `protein_associations` (
  `id` int(11) NOT NULL,
  `deficiency_id` int(11) NOT NULL,
  `protein_name` varchar(255) DEFAULT NULL,
  `uniprot_accession` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `protein_associations`
--

INSERT INTO `protein_associations` (`id`, `deficiency_id`, `protein_name`, `uniprot_accession`) VALUES
(1, 1, 'Ferritin Heavy Chain', 'P02794'),
(2, 1, 'Transferrin', 'P02787'),
(3, 1, 'Transferrin Receptor Protein 2', 'Q9UP52'),
(4, 1, 'Ferroportin', 'Q9NP59'),
(5, 1, 'Hepcidin', 'P81172'),
(6, 2, 'Vitamin D receptor', 'P11473'),
(7, 2, '25-hydroxyvitamin D 1-alpha-hydroxylase', 'O15528'),
(8, 2, 'Vitamin D 24-hydroxylase', 'Q07973'),
(9, 2, 'Vitamin D-binding protein', 'P02774'),
(10, 3, 'Transcobalamin-2', 'P20062'),
(11, 3, 'Gastric intrinsic factor', 'P27352'),
(12, 3, 'Cubilin', 'O60494'),
(13, 3, 'Cobalamin-processing protein MMACHC', 'Q9Y4U1'),
(14, 15, 'Magnesium channel TRPM6', 'Q9BX84'),
(15, 15, 'Metal transporter CNNM2', 'Q9H8M5'),
(16, 15, 'Sodium/potassium-transporting ATPase subunit gamma', 'P54710'),
(21, 4, 'Retinol-binding protein 4', 'P02753'),
(22, 4, 'Retinol uptake receptor STRA6', 'Q9BX79'),
(23, 4, 'Beta-carotene 15,15-dioxygenase', 'Q9HAY6'),
(24, 5, 'Sodium-dependent vitamin C transporter 1', 'Q9UHI7'),
(25, 5, 'Sodium-dependent vitamin C transporter 2', 'Q9UGH3'),
(26, 6, 'Alpha-tocopherol transfer protein', 'P49638'),
(27, 6, 'Apolipoprotein B-100', 'P04114'),
(28, 7, 'Vitamin K epoxide reductase complex subunit 1', 'Q9BQB6'),
(29, 7, 'Gamma-glutamyl carboxylase', 'P38435'),
(30, 7, 'Cytochrome P450 4F2', 'P78329'),
(31, 8, 'Thiamine transporter 1', 'O60779'),
(32, 8, 'Thiamine transporter 2', 'Q9BZV2'),
(33, 8, 'Thiamine pyrophosphokinase 1', 'Q9H3S4'),
(34, 9, 'Riboflavin transporter 1', 'Q9NWF4'),
(35, 9, 'Riboflavin transporter 3', 'Q9HAB3'),
(36, 9, 'Riboflavin kinase', 'Q969G6'),
(37, 9, 'FAD synthase', 'Q8NFF5'),
(38, 10, 'Nicotinate phosphoribosyltransferase', 'Q6XQN6'),
(39, 10, 'Quinolinate phosphoribosyltransferase', 'Q15274'),
(40, 10, 'Nicotinamide nucleotide adenylyltransferase 1', 'Q9HAN9'),
(41, 10, 'NAD synthetase 1', 'Q6IA69'),
(42, 11, 'Pyridoxal kinase', 'O00764'),
(43, 11, 'Pyridoxine-5-prime-phosphate oxidase', 'Q9NVS9'),
(44, 11, 'Pyridoxal phosphate homeostasis protein', 'O94903'),
(45, 11, 'Tissue-nonspecific alkaline phosphatase', 'P05186'),
(46, 12, 'Sodium-dependent multivitamin transporter', 'Q9Y289'),
(47, 12, 'Biotinidase', 'P43251'),
(48, 12, 'Holocarboxylase synthetase', 'P50747'),
(49, 13, 'Reduced folate transporter', 'P41440'),
(50, 13, 'Dihydrofolate reductase', 'P00374'),
(51, 13, 'Methylenetetrahydrofolate reductase', 'P42898'),
(52, 14, 'Epithelial calcium channel TRPV6', 'Q9H1D0'),
(53, 14, 'Calcium-sensing receptor', 'P41180'),
(54, 14, 'Vitamin D receptor', 'P11473'),
(55, 15, 'Magnesium transporter SLC41A1', 'Q8IVJ1'),
(56, 16, 'Zinc transporter ZIP4', 'Q6P5W5'),
(57, 16, 'Zinc transporter 1', 'Q9Y6M5'),
(58, 16, 'Metal cation transporter ZIP8', 'Q9C0K1'),
(59, 17, 'Copper-transporting ATPase 1', 'Q04656'),
(60, 17, 'Copper-transporting ATPase 2', 'P35670'),
(61, 17, 'High-affinity copper uptake protein 1', 'O15431'),
(62, 17, 'Ceruloplasmin', 'P00450'),
(63, 18, 'Sodium/iodide cotransporter', 'Q92911'),
(64, 18, 'Thyroid peroxidase', 'P07202'),
(65, 18, 'Thyroglobulin', 'P01266'),
(66, 18, 'Iodotyrosine deiodinase 1', 'Q6PHW0'),
(67, 19, 'Selenoprotein P', 'P49908'),
(68, 19, 'Glutathione peroxidase 1', 'P07203'),
(69, 19, 'O-phosphoseryl-tRNA(Sec) synthase', 'Q9HD40'),
(70, 20, 'Sodium/potassium-transporting ATPase subunit alpha-1', 'P05023'),
(71, 20, 'ATP-sensitive inward rectifier potassium channel 1', 'P48048'),
(72, 20, 'Sodium-potassium-chloride cotransporter 1', 'Q13621');

-- --------------------------------------------------------

--
-- Table structure for table `protein_association_metadata`
--

CREATE TABLE `protein_association_metadata` (
  `association_id` int(11) NOT NULL,
  `protein_function` text NOT NULL,
  `association_description` text NOT NULL,
  `source_url` varchar(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `protein_association_metadata`
--

INSERT INTO `protein_association_metadata` (`association_id`, `protein_function`, `association_description`, `source_url`) VALUES
(1, 'Ferritin stores iron intracellularly and helps manage iron availability.', 'Biological iron-related function is provided as context only; this association does not establish a cause or diagnosis of nutritional deficiency.', 'https://www.uniprot.org/uniprotkb/P02794'),
(2, 'Transferrin binds and transports iron in blood.', 'Biological iron-related function is provided as context only; this association does not establish a cause or diagnosis of nutritional deficiency.', 'https://www.uniprot.org/uniprotkb/P02787'),
(3, 'Transferrin receptor 2 participates in cellular iron sensing and regulation.', 'Biological iron-related function is provided as context only; this association does not establish a cause or diagnosis of nutritional deficiency.', 'https://www.uniprot.org/uniprotkb/Q9UP52'),
(4, 'Ferroportin exports iron from cells and is encoded by SLC40A1.', 'Biological iron-related function is provided as context only; this association does not establish a cause or diagnosis of nutritional deficiency.', 'https://www.uniprot.org/uniprotkb/Q9NP59'),
(5, 'Hepcidin is a peptide hormone that regulates iron export and systemic iron availability.', 'Biological iron-related function is provided as context only; this association does not establish a cause or diagnosis of nutritional deficiency.', 'https://www.uniprot.org/uniprotkb/P81172'),
(6, 'Vitamin D-activated nuclear receptor that regulates transcription, including genes involved in mineral metabolism.', 'Protein function provides pathway context only and does not establish an individual deficiency.', 'https://www.uniprot.org/uniprotkb/P11473'),
(7, 'Catalyzes formation of active 1,25-dihydroxyvitamin D from its precursor.', 'Protein function provides pathway context only and does not establish an individual deficiency.', 'https://www.uniprot.org/uniprotkb/O15528'),
(8, 'Initiates inactivation of active vitamin D metabolites through 24-hydroxylation.', 'Protein function provides pathway context only and does not establish an individual deficiency.', 'https://www.uniprot.org/uniprotkb/Q07973'),
(9, 'Binds and transports vitamin D metabolites in blood.', 'Protein function provides pathway context only and does not establish an individual deficiency.', 'https://www.uniprot.org/uniprotkb/P02774'),
(10, 'Binds cobalamin in plasma and mediates its delivery to cells.', 'Protein function provides pathway context only and does not establish an individual deficiency.', 'https://www.uniprot.org/uniprotkb/P20062'),
(11, 'Binds dietary vitamin B12 in the stomach and supports its absorption.', 'Protein function provides pathway context only and does not establish an individual deficiency.', 'https://www.uniprot.org/uniprotkb/P27352'),
(12, 'Part of the intestinal receptor complex that takes up intrinsic factor-bound cobalamin.', 'Protein function provides pathway context only and does not establish an individual deficiency.', 'https://www.uniprot.org/uniprotkb/O60494'),
(13, 'Processes intracellular cobalamin into cofactor forms.', 'This protein also participates in inherited cobalamin metabolism; its record is not a dietary deficiency diagnosis.', 'https://www.uniprot.org/uniprotkb/Q9Y4U1'),
(14, 'Epithelial cation channel/kinase involved in magnesium absorption and transport.', 'Protein function provides pathway context only and does not establish an individual deficiency.', 'https://www.uniprot.org/uniprotkb/Q9BX84'),
(15, 'Divalent metal transport mediator with a role in magnesium handling.', 'Protein function provides pathway context only and does not establish an individual deficiency.', 'https://www.uniprot.org/uniprotkb/Q9H8M5'),
(16, 'Regulatory gamma subunit of the sodium/potassium ATPase, as annotated by UniProt.', 'This is the FXYD2 gene product; the separate inherited renal hypomagnesemia association is not evidence of dietary deficiency.', 'https://www.uniprot.org/uniprotkb/P54710'),
(21, 'Binds and transports retinol in plasma.', 'This protein provides vitamin A transport context and does not diagnose deficiency.', 'https://www.uniprot.org/uniprotkb/P02753'),
(22, 'Receptor mediating cellular uptake of retinol bound to retinol-binding protein.', 'This protein provides vitamin A uptake context and does not diagnose deficiency.', 'https://www.uniprot.org/uniprotkb/Q9BX79'),
(23, 'Cleaves provitamin A carotenoids to produce retinal.', 'This metabolic function does not establish an individual\'s vitamin A status.', 'https://www.uniprot.org/uniprotkb/Q9HAY6'),
(24, 'Sodium-dependent transporter for cellular uptake of ascorbate.', 'Transport function is molecular context and does not diagnose vitamin C deficiency.', 'https://www.uniprot.org/uniprotkb/Q9UHI7'),
(25, 'Sodium-dependent transporter for cellular uptake of ascorbate.', 'Transport function is molecular context and does not diagnose vitamin C deficiency.', 'https://www.uniprot.org/uniprotkb/Q9UGH3'),
(26, 'Transfers alpha-tocopherol between membranes and supports its distribution.', 'This biological role does not establish an individual\'s vitamin E status.', 'https://www.uniprot.org/uniprotkb/P49638'),
(27, 'Structural apolipoprotein of lipoprotein particles that transport dietary lipids.', 'Lipoprotein transport provides context for a fat-soluble nutrient and does not diagnose deficiency.', 'https://www.uniprot.org/uniprotkb/P04114'),
(28, 'Catalyzes vitamin K epoxide reduction in the vitamin K cycle.', 'This pathway function does not diagnose vitamin K deficiency.', 'https://www.uniprot.org/uniprotkb/Q9BQB6'),
(29, 'Catalyzes gamma-carboxylation of vitamin-K-dependent proteins.', 'This pathway function does not establish an individual\'s vitamin K status.', 'https://www.uniprot.org/uniprotkb/P38435'),
(30, 'Cytochrome P450 enzyme that participates in vitamin K catabolism.', 'This metabolic context does not diagnose vitamin K deficiency.', 'https://www.uniprot.org/uniprotkb/P78329'),
(31, 'Thiamin transporter involved in cellular uptake.', 'Transport function does not establish dietary thiamin status.', 'https://www.uniprot.org/uniprotkb/O60779'),
(32, 'Thiamin transporter involved in cellular uptake.', 'Transport function does not establish dietary thiamin status.', 'https://www.uniprot.org/uniprotkb/Q9BZV2'),
(33, 'Converts thiamin to the active cofactor thiamin diphosphate.', 'This biochemical function does not diagnose vitamin B1 deficiency.', 'https://www.uniprot.org/uniprotkb/Q9H3S4'),
(34, 'Riboflavin transporter involved in vitamin B2 uptake.', 'Transport function does not establish an individual\'s riboflavin status.', 'https://www.uniprot.org/uniprotkb/Q9NWF4'),
(35, 'Riboflavin transporter involved in vitamin B2 uptake.', 'Transport function does not establish an individual\'s riboflavin status.', 'https://www.uniprot.org/uniprotkb/Q9HAB3'),
(36, 'Phosphorylates riboflavin to form FMN.', 'This biochemical function does not diagnose vitamin B2 deficiency.', 'https://www.uniprot.org/uniprotkb/Q969G6'),
(37, 'Synthesizes FAD from FMN and ATP.', 'This biochemical function does not diagnose vitamin B2 deficiency.', 'https://www.uniprot.org/uniprotkb/Q8NFF5'),
(38, 'Catalyzes the nicotinate phosphoribosyltransferase step in NAD biosynthesis.', 'NAD metabolism context does not diagnose niacin deficiency.', 'https://www.uniprot.org/uniprotkb/Q6XQN6'),
(39, 'Catalyzes a step in de novo NAD biosynthesis from tryptophan-derived quinolinate.', 'NAD metabolism context does not establish dietary niacin status.', 'https://www.uniprot.org/uniprotkb/Q15274'),
(40, 'Forms NAD from nicotinamide or nicotinic acid mononucleotide.', 'This biochemical function does not diagnose niacin deficiency.', 'https://www.uniprot.org/uniprotkb/Q9HAN9'),
(41, 'Catalyzes the final amidation step in NAD biosynthesis.', 'This biochemical function does not establish dietary niacin status.', 'https://www.uniprot.org/uniprotkb/Q6IA69'),
(42, 'Phosphorylates vitamin B6 vitamers in the pyridoxal phosphate pathway.', 'This biochemical function does not diagnose vitamin B6 deficiency.', 'https://www.uniprot.org/uniprotkb/O00764'),
(43, 'Produces pyridoxal phosphate, the active vitamin B6 cofactor.', 'This biochemical function does not establish an individual\'s vitamin B6 status.', 'https://www.uniprot.org/uniprotkb/Q9NVS9'),
(44, 'Binds pyridoxal phosphate and contributes to its intracellular homeostasis.', 'This function is molecular context, not a dietary deficiency diagnosis.', 'https://www.uniprot.org/uniprotkb/O94903'),
(45, 'Hydrolyzes several phosphate monoesters, including pyridoxal phosphate.', 'This enzyme function alone does not diagnose vitamin B6 deficiency.', 'https://www.uniprot.org/uniprotkb/P05186'),
(46, 'Transports biotin and other water-soluble vitamins across cell membranes.', 'This transporter is not specific to biotin and does not establish deficiency.', 'https://www.uniprot.org/uniprotkb/Q9Y289'),
(47, 'Releases biotin from biocytin and biotinylated peptides for recycling.', 'This recycling role does not diagnose nutritional biotin deficiency.', 'https://www.uniprot.org/uniprotkb/P43251'),
(48, 'Attaches biotin to carboxylase enzymes.', 'This biochemical function does not establish individual biotin status.', 'https://www.uniprot.org/uniprotkb/P50747'),
(49, 'Transports reduced folates into cells.', 'Transport function does not diagnose folate deficiency.', 'https://www.uniprot.org/uniprotkb/P41440'),
(50, 'Reduces dihydrofolate to tetrahydrofolate for one-carbon metabolism.', 'This pathway function does not establish an individual\'s folate status.', 'https://www.uniprot.org/uniprotkb/P00374'),
(51, 'Catalyzes a folate-dependent reaction in one-carbon metabolism.', 'This pathway function does not diagnose folate deficiency.', 'https://www.uniprot.org/uniprotkb/P42898'),
(52, 'Epithelial calcium channel involved in intestinal calcium absorption.', 'This function does not determine dietary calcium status.', 'https://www.uniprot.org/uniprotkb/Q9H1D0'),
(53, 'Cell-surface receptor that senses extracellular calcium and regulates calcium homeostasis.', 'This role does not diagnose dietary calcium deficiency.', 'https://www.uniprot.org/uniprotkb/P41180'),
(54, 'Nuclear receptor for active vitamin D that regulates genes involved in mineral metabolism.', 'This provides calcium absorption context and does not establish deficiency.', 'https://www.uniprot.org/uniprotkb/P11473'),
(55, 'Magnesium transporter implicated in cellular magnesium homeostasis.', 'This protein function does not diagnose dietary magnesium deficiency.', 'https://www.uniprot.org/uniprotkb/Q8IVJ1'),
(56, 'ZIP-family transporter that imports zinc into cells.', 'This transport function does not establish individual zinc status.', 'https://www.uniprot.org/uniprotkb/Q6P5W5'),
(57, 'Zinc transporter that exports zinc from the cytoplasm or loads intracellular compartments.', 'This transport function does not diagnose zinc deficiency.', 'https://www.uniprot.org/uniprotkb/Q9Y6M5'),
(58, 'ZIP-family metal transporter with zinc transport activity.', 'This transport function does not establish dietary zinc status.', 'https://www.uniprot.org/uniprotkb/Q9C0K1'),
(59, 'Copper-transporting ATPase involved in intracellular copper distribution.', 'Transport biology does not diagnose dietary copper deficiency.', 'https://www.uniprot.org/uniprotkb/Q04656'),
(60, 'Copper-transporting ATPase involved in copper handling and export.', 'Transport biology does not diagnose dietary copper deficiency.', 'https://www.uniprot.org/uniprotkb/P35670'),
(61, 'High-affinity transporter for cellular copper uptake.', 'Transport biology does not establish an individual\'s copper status.', 'https://www.uniprot.org/uniprotkb/O15431'),
(62, 'Copper-containing plasma ferroxidase.', 'This protein function is molecular context and does not diagnose deficiency.', 'https://www.uniprot.org/uniprotkb/P00450'),
(63, 'Concentrates iodide in thyroid cells through sodium-coupled transport.', 'This transport function does not establish dietary iodine status.', 'https://www.uniprot.org/uniprotkb/Q92911'),
(64, 'Catalyzes iodination and coupling reactions in thyroid hormone synthesis.', 'This function does not diagnose iodine deficiency.', 'https://www.uniprot.org/uniprotkb/P07202'),
(65, 'Thyroid hormone precursor and scaffold for hormone synthesis.', 'This function does not establish an individual\'s iodine status.', 'https://www.uniprot.org/uniprotkb/P01266'),
(66, 'Recycles iodide from iodinated tyrosine residues.', 'This recycling function does not diagnose dietary iodine deficiency.', 'https://www.uniprot.org/uniprotkb/Q6PHW0'),
(67, 'Selenium-containing protein involved in selenium transport.', 'Transport function does not establish an individual\'s selenium status.', 'https://www.uniprot.org/uniprotkb/P49908'),
(68, 'Selenium-dependent enzyme that reduces peroxides.', 'This biochemical function does not diagnose selenium deficiency.', 'https://www.uniprot.org/uniprotkb/P07203'),
(69, 'Required for synthesis of selenocysteine on its tRNA during selenoprotein production.', 'This function is molecular context, not a dietary deficiency diagnosis.', 'https://www.uniprot.org/uniprotkb/Q9HD40'),
(70, 'Subunit of the sodium/potassium pump that maintains cellular ion gradients.', 'This function does not diagnose dietary potassium deficiency.', 'https://www.uniprot.org/uniprotkb/P05023'),
(71, 'Renal inward-rectifier potassium channel involved in potassium transport.', 'This function does not establish an individual\'s potassium status.', 'https://www.uniprot.org/uniprotkb/P48048'),
(72, 'Renal sodium-potassium-chloride cotransporter involved in electrolyte handling.', 'This function does not diagnose dietary potassium deficiency.', 'https://www.uniprot.org/uniprotkb/Q13621');

-- --------------------------------------------------------

--
-- Table structure for table `stage_dataset_sources`
--

CREATE TABLE `stage_dataset_sources` (
  `source_id` int(11) NOT NULL,
  `dataset_name` varchar(255) NOT NULL,
  `organization` varchar(255) NOT NULL,
  `source_url` varchar(2048) NOT NULL,
  `record_identifier` varchar(255) NOT NULL,
  `version_or_release` varchar(100) NOT NULL,
  `access_date` date NOT NULL,
  `license` text NOT NULL,
  `verification_status` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stage_dataset_sources`
--

INSERT INTO `stage_dataset_sources` (`source_id`, `dataset_name`, `organization`, `source_url`, `record_identifier`, `version_or_release`, `access_date`, `license`, `verification_status`) VALUES
(1, 'Deficiency, symptom, and association masters', 'DefiMap local project database', '', 'Current live rows in deficiency_master, symptom_master, and deficiency_symptoms', 'Unknown', '2026-10-18', 'Unknown; project reuse terms not supplied', 'Exported from local schema; scientific source verification remains incomplete.'),
(2, 'Food recommendations', 'DefiMap local project database', '', 'Current live food_recommendations rows', 'Unknown', '2026-10-18', 'Unknown; project reuse terms not supplied', 'Exported without overwriting records; food descriptions need claim-level review.'),
(3, 'Food composition reference', 'USDA Agricultural Research Service, FoodData Central', 'https://fdc.nal.usda.gov/', 'No FoodData Central record IDs or nutrient quantities imported', 'Unknown', '2026-10-18', 'CC0 1.0 Universal; USDA requests attribution', 'Official licensing page states USDA FDC data are public domain and CC0; no composition values or serving sizes are asserted in these CSVs.'),
(4, 'Symptom terminology', 'U.S. National Library of Medicine, MedlinePlus', 'https://medlineplus.gov/symptoms.html', 'General symptoms information page', 'Unknown', '2026-10-18', 'U.S. government-created NLM content is public domain; third-party content may have separate restrictions', 'Official MedlinePlus symptoms entry point recorded; individual symptom definitions are cautious project glosses, not copied clinical text.'),
(5, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/', 'Iron-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(6, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/VitaminD-HealthProfessional/', 'VitaminD-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(7, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/VitaminB12-HealthProfessional/', 'VitaminB12-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(8, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/VitaminA-HealthProfessional/', 'VitaminA-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(9, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/VitaminC-HealthProfessional/', 'VitaminC-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(10, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/VitaminE-HealthProfessional/', 'VitaminE-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(11, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/VitaminK-HealthProfessional/', 'VitaminK-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(12, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/Thiamin-HealthProfessional/', 'Thiamin-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(13, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/Riboflavin-HealthProfessional/', 'Riboflavin-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(14, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/Niacin-HealthProfessional/', 'Niacin-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(15, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/VitaminB6-HealthProfessional/', 'VitaminB6-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(16, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/Biotin-HealthProfessional/', 'Biotin-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(17, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/Folate-HealthProfessional/', 'Folate-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(18, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/Calcium-HealthProfessional/', 'Calcium-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(19, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/Magnesium-HealthProfessional/', 'Magnesium-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(20, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/Zinc-HealthProfessional/', 'Zinc-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(21, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/Copper-HealthProfessional/', 'Copper-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(22, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/Iodine-HealthProfessional/', 'Iodine-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(23, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/Selenium-HealthProfessional/', 'Selenium-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(24, 'Deficiency master, symptom mapping, and food context', 'NIH Office of Dietary Supplements', 'https://ods.od.nih.gov/factsheets/Potassium-HealthProfessional/', 'Potassium-HealthProfessional', 'Unknown', '2026-10-18', 'Unknown; page-specific reuse notices and third-party materials require review', 'Official NIH ODS URL recorded; automated retrieval returned HTTP 403 during this run, so page content and claim-level support were not independently verified.'),
(25, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/57817', 'NCBI Gene 57817', 'Unknown', '2026-10-18', 'NCBI places no restrictions on molecular database data; submitter and third-party rights may still apply', 'Identifier and record URL are retained from the current project data; verify the live NCBI record and any submitter notices before reuse.'),
(26, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/3077', 'NCBI Gene 3077', 'Unknown', '2026-10-18', 'NCBI places no restrictions on molecular database data; submitter and third-party rights may still apply', 'Identifier and record URL are retained from the current project data; verify the live NCBI record and any submitter notices before reuse.'),
(27, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/30061', 'NCBI Gene 30061', 'Unknown', '2026-10-18', 'NCBI places no restrictions on molecular database data; submitter and third-party rights may still apply', 'Identifier and record URL are retained from the current project data; verify the live NCBI record and any submitter notices before reuse.'),
(28, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/7018', 'NCBI Gene 7018', 'Unknown', '2026-10-18', 'NCBI places no restrictions on molecular database data; submitter and third-party rights may still apply', 'Identifier and record URL are retained from the current project data; verify the live NCBI record and any submitter notices before reuse.'),
(29, 'Gene associations', 'NCBI Gene / National Center for Biotechnology Information', 'https://www.ncbi.nlm.nih.gov/gene/7036', 'NCBI Gene 7036', 'Unknown', '2026-10-18', 'NCBI places no restrictions on molecular database data; submitter and third-party rights may still apply', 'Identifier and record URL are retained from the current project data; verify the live NCBI record and any submitter notices before reuse.'),
(30, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P02794', 'UniProt accession P02794', 'Unknown', '2026-10-18', 'Unknown; verify current UniProtKB license and attribution terms before redistribution', 'Accession and record URL are retained from the current project data; confirm the live UniProt record and current license before reuse.'),
(31, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q9NP59', 'UniProt accession Q9NP59', 'Unknown', '2026-10-18', 'Unknown; verify current UniProtKB license and attribution terms before redistribution', 'Accession and record URL are retained from the current project data; confirm the live UniProt record and current license before reuse.'),
(32, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P81172', 'UniProt accession P81172', 'Unknown', '2026-10-18', 'Unknown; verify current UniProtKB license and attribution terms before redistribution', 'Accession and record URL are retained from the current project data; confirm the live UniProt record and current license before reuse.'),
(33, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/P02787', 'UniProt accession P02787', 'Unknown', '2026-10-18', 'Unknown; verify current UniProtKB license and attribution terms before redistribution', 'Accession and record URL are retained from the current project data; confirm the live UniProt record and current license before reuse.'),
(34, 'Protein associations', 'UniProt Consortium', 'https://www.uniprot.org/uniprotkb/Q9UP52', 'UniProt accession Q9UP52', 'Unknown', '2026-10-18', 'Unknown; verify current UniProtKB license and attribution terms before redistribution', 'Accession and record URL are retained from the current project data; confirm the live UniProt record and current license before reuse.'),
(35, 'Biological pathway associations', 'Reactome', 'https://reactome.org/', 'Existing local label: Cellular Iron Uptake', 'Unknown', '2026-10-18', 'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms', 'Reactome license reviewed; no exact Reactome identifier is asserted for this local label.'),
(36, 'Biological pathway associations', 'Reactome', 'https://reactome.org/', 'Existing local label: Erythropoiesis', 'Unknown', '2026-10-18', 'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms', 'Reactome license reviewed; no exact Reactome identifier is asserted for this local label.'),
(37, 'Biological pathway associations', 'Reactome', 'https://reactome.org/', 'Existing local label: HIF-1 Signaling Pathway', 'Unknown', '2026-10-18', 'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms', 'Reactome license reviewed; no exact Reactome identifier is asserted for this local label.'),
(38, 'Biological pathway associations', 'Reactome', 'https://reactome.org/', 'Existing local label: Iron Homeostasis', 'Unknown', '2026-10-18', 'Reactome data are CC0; pathway illustrations are CC BY 4.0; other materials have separate terms', 'Reactome license reviewed; no exact Reactome identifier is asserted for this local label.');

-- --------------------------------------------------------

--
-- Table structure for table `stage_deficiency_master`
--

CREATE TABLE `stage_deficiency_master` (
  `deficiency_id` int(11) NOT NULL,
  `deficiency_name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `related_nutrient` varchar(100) NOT NULL,
  `source_url` varchar(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stage_deficiency_master`
--

INSERT INTO `stage_deficiency_master` (`deficiency_id`, `deficiency_name`, `description`, `related_nutrient`, `source_url`) VALUES
(1, 'Iron Deficiency', 'Iron deficiency occurs when the body lacks enough iron to produce healthy red blood cells.', 'Iron', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(2, 'Vitamin D Deficiency', 'Vitamin D deficiency weakens bones and muscles by reducing calcium absorption.', 'Vitamin D', 'https://ods.od.nih.gov/factsheets/VitaminD-HealthProfessional/'),
(3, 'Vitamin B12 Deficiency', 'Inadequate availability of Vitamin B12; clinical status requires appropriate assessment.', 'Vitamin B12', 'https://ods.od.nih.gov/factsheets/VitaminB12-HealthProfessional/'),
(4, 'Vitamin A Deficiency', 'Vitamin A deficiency affects vision, immunity, and healthy skin.', 'Vitamin A', 'https://ods.od.nih.gov/factsheets/VitaminA-HealthProfessional/'),
(5, 'Vitamin C Deficiency', 'Vitamin C deficiency reduces collagen production and weakens immunity.', 'Vitamin C', 'https://ods.od.nih.gov/factsheets/VitaminC-HealthProfessional/'),
(6, 'Vitamin E Deficiency', 'Vitamin E deficiency damages nerves and muscles due to antioxidant deficiency.', 'Vitamin E', 'https://ods.od.nih.gov/factsheets/VitaminE-HealthProfessional/'),
(7, 'Vitamin K Deficiency', 'Vitamin K deficiency affects blood clotting and bone health.', 'Vitamin K', 'https://ods.od.nih.gov/factsheets/VitaminK-HealthProfessional/'),
(8, 'Vitamin B1 Deficiency', 'Vitamin B1 deficiency affects the nervous system and energy production.', 'Vitamin B1 (thiamin)', 'https://ods.od.nih.gov/factsheets/Thiamin-HealthProfessional/'),
(9, 'Vitamin B2 Deficiency', 'Vitamin B2 deficiency affects skin, eyes, and energy metabolism.', 'Vitamin B2 (riboflavin)', 'https://ods.od.nih.gov/factsheets/Riboflavin-HealthProfessional/'),
(10, 'Vitamin B3 Deficiency', 'Vitamin B3 deficiency causes pellagra and affects the digestive and nervous systems.', 'Vitamin B3 (niacin)', 'https://ods.od.nih.gov/factsheets/Niacin-HealthProfessional/'),
(11, 'Vitamin B6 Deficiency', 'Vitamin B6 deficiency affects brain function and red blood cell formation.', 'Vitamin B6', 'https://ods.od.nih.gov/factsheets/VitaminB6-HealthProfessional/'),
(12, 'Biotin Deficiency', 'Biotin deficiency affects hair, skin, and nail health.', 'Biotin', 'https://ods.od.nih.gov/factsheets/Biotin-HealthProfessional/'),
(13, 'Folate Deficiency', 'Folate deficiency reduces healthy red blood cell production and DNA synthesis.', 'Folate', 'https://ods.od.nih.gov/factsheets/Folate-HealthProfessional/'),
(14, 'Calcium Deficiency', 'Calcium deficiency weakens bones and teeth.', 'Calcium', 'https://ods.od.nih.gov/factsheets/Calcium-HealthProfessional/'),
(15, 'Magnesium Deficiency', 'Magnesium deficiency affects muscles, nerves, and heart rhythm.', 'Magnesium', 'https://ods.od.nih.gov/factsheets/Magnesium-HealthProfessional/'),
(16, 'Zinc Deficiency', 'Zinc deficiency weakens immunity and delays wound healing.', 'Zinc', 'https://ods.od.nih.gov/factsheets/Zinc-HealthProfessional/'),
(17, 'Copper Deficiency', 'Copper deficiency affects blood formation and nervous system function.', 'Copper', 'https://ods.od.nih.gov/factsheets/Copper-HealthProfessional/'),
(18, 'Iodine Deficiency', 'Iodine deficiency reduces thyroid hormone production.', 'Iodine', 'https://ods.od.nih.gov/factsheets/Iodine-HealthProfessional/'),
(19, 'Selenium Deficiency', 'Selenium deficiency weakens antioxidant defense and immunity.', 'Selenium', 'https://ods.od.nih.gov/factsheets/Selenium-HealthProfessional/'),
(20, 'Potassium Deficiency', 'Potassium deficiency affects muscles, nerves, and heart function.', 'Potassium', 'https://ods.od.nih.gov/factsheets/Potassium-HealthProfessional/');

-- --------------------------------------------------------

--
-- Table structure for table `stage_deficiency_symptoms`
--

CREATE TABLE `stage_deficiency_symptoms` (
  `deficiency_id` int(11) NOT NULL,
  `symptom_id` int(11) NOT NULL,
  `weight` int(11) NOT NULL,
  `evidence_note` text NOT NULL,
  `source_url` varchar(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stage_deficiency_symptoms`
--

INSERT INTO `stage_deficiency_symptoms` (`deficiency_id`, `symptom_id`, `weight`, `evidence_note`, `source_url`) VALUES
(1, 1, 5, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(1, 2, 4, 'Existing DefiMap rule weight 4/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(1, 4, 5, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(1, 18, 5, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(1, 19, 3, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(2, 7, 3, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminD-HealthProfessional/'),
(2, 8, 5, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminD-HealthProfessional/'),
(2, 14, 2, 'Existing DefiMap rule weight 2/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminD-HealthProfessional/'),
(3, 9, 5, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminB12-HealthProfessional/'),
(3, 10, 4, 'Existing DefiMap rule weight 4/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminB12-HealthProfessional/'),
(3, 13, 5, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminB12-HealthProfessional/'),
(3, 14, 3, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminB12-HealthProfessional/'),
(4, 2, 3, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminA-HealthProfessional/'),
(4, 5, 5, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminA-HealthProfessional/'),
(5, 2, 3, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminC-HealthProfessional/'),
(5, 11, 5, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminC-HealthProfessional/'),
(7, 9, 5, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminK-HealthProfessional/'),
(8, 1, 5, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Thiamin-HealthProfessional/'),
(8, 2, 4, 'Existing DefiMap rule weight 4/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Thiamin-HealthProfessional/'),
(9, 7, 2, 'Existing DefiMap rule weight 2/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Riboflavin-HealthProfessional/'),
(9, 10, 4, 'Existing DefiMap rule weight 4/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Riboflavin-HealthProfessional/'),
(10, 14, 2, 'Existing DefiMap rule weight 2/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Niacin-HealthProfessional/'),
(10, 16, 4, 'Existing DefiMap rule weight 4/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Niacin-HealthProfessional/'),
(11, 10, 3, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminB6-HealthProfessional/'),
(11, 16, 4, 'Existing DefiMap rule weight 4/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/VitaminB6-HealthProfessional/'),
(12, 3, 5, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Biotin-HealthProfessional/'),
(12, 7, 3, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Biotin-HealthProfessional/'),
(12, 17, 4, 'Existing DefiMap rule weight 4/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Biotin-HealthProfessional/'),
(13, 1, 5, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Folate-HealthProfessional/'),
(13, 2, 4, 'Existing DefiMap rule weight 4/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Folate-HealthProfessional/'),
(13, 4, 5, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Folate-HealthProfessional/'),
(14, 5, 5, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Calcium-HealthProfessional/'),
(14, 6, 4, 'Existing DefiMap rule weight 4/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Calcium-HealthProfessional/'),
(15, 6, 5, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Magnesium-HealthProfessional/'),
(15, 11, 3, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Magnesium-HealthProfessional/'),
(15, 12, 3, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Magnesium-HealthProfessional/'),
(16, 3, 3, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Zinc-HealthProfessional/'),
(16, 13, 4, 'Existing DefiMap rule weight 4/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Zinc-HealthProfessional/'),
(16, 17, 4, 'Existing DefiMap rule weight 4/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Zinc-HealthProfessional/'),
(17, 3, 4, 'Existing DefiMap rule weight 4/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Copper-HealthProfessional/'),
(17, 4, 3, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Copper-HealthProfessional/'),
(18, 1, 2, 'Existing DefiMap rule weight 2/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Iodine-HealthProfessional/'),
(18, 20, 5, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Iodine-HealthProfessional/'),
(19, 1, 3, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Selenium-HealthProfessional/'),
(19, 3, 3, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Selenium-HealthProfessional/'),
(20, 2, 4, 'Existing DefiMap rule weight 4/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Potassium-HealthProfessional/'),
(20, 6, 5, 'Existing DefiMap rule weight 5/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Potassium-HealthProfessional/'),
(20, 19, 3, 'Existing DefiMap rule weight 3/5 exported unchanged. This project-defined heuristic is not clinically validated and is not a probability. The linked nutrient fact sheet is background context and does not verify this symptom-to-deficiency pair.', 'https://ods.od.nih.gov/factsheets/Potassium-HealthProfessional/');

-- --------------------------------------------------------

--
-- Table structure for table `stage_food_recommendations`
--

CREATE TABLE `stage_food_recommendations` (
  `deficiency_id` int(11) NOT NULL,
  `food_name` varchar(255) NOT NULL,
  `nutrient_name` varchar(100) NOT NULL,
  `benefit` text NOT NULL,
  `caution` text NOT NULL,
  `source_url` varchar(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stage_food_recommendations`
--

INSERT INTO `stage_food_recommendations` (`deficiency_id`, `food_name`, `nutrient_name`, `benefit`, `caution`, `source_url`) VALUES
(1, 'Beans', 'Iron', 'Provide plant-based (non-heme) iron, protein and fiber. Pair with vitamin C-rich foods to support iron absorption.', 'Tea and coffee can reduce absorption of plant-based iron; have them between meals rather than with iron-rich meals.', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(1, 'Beetroot', 'Iron', 'Provides folate, fiber and antioxidants, but is not a concentrated source of iron.', 'Do not rely on beetroot as the primary iron source; include iron-rich foods and follow clinical advice.', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(1, 'Broccoli', 'Iron', 'Provides vitamin C, which can support absorption of non-heme iron from foods such as beans and lentils.', 'No general restriction is needed unless you have an allergy or have been given specific dietary advice.', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(1, 'Chicken Liver', 'Iron', 'Provides readily absorbed heme iron, vitamin B12 and folate.', 'Avoid frequent large servings because liver is high in vitamin A; avoid during pregnancy unless your clinician advises otherwise.', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(1, 'Lentils', 'Iron', 'Provide plant-based (non-heme) iron, protein and fiber. Pair with vitamin C-rich foods to support iron absorption.', 'Tea and coffee can reduce absorption of plant-based iron; have them between meals rather than with iron-rich meals.', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(1, 'Pumpkin Seeds', 'Iron', 'Provide plant-based iron, protein and magnesium.', 'Avoid if you have a seed allergy; otherwise, use portions that fit your dietary needs.', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(1, 'Red Meat', 'Iron', 'Provides readily absorbed heme iron, vitamin B12 and protein.', 'Limit excessive portions and processed meats; choose lean, unprocessed options when possible.', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(1, 'Spinach', 'Iron', 'Excellent source of iron for healthy red blood cells.', 'Avoid excessive tea or coffee immediately after meals.', 'https://ods.od.nih.gov/factsheets/Iron-HealthProfessional/'),
(2, 'Salmon', 'Vitamin D', 'Provides vitamin D and protein; amounts vary by species and serving.', 'Avoid if you have a fish allergy; food alone may not correct a confirmed deficiency.', 'https://ods.od.nih.gov/factsheets/VitaminD-HealthProfessional/'),
(2, 'Trout', 'Vitamin D', 'Provides vitamin D and protein; amounts vary by source and serving.', 'Avoid if you have a fish allergy; follow local fish-safety advice.', 'https://ods.od.nih.gov/factsheets/VitaminD-HealthProfessional/'),
(2, 'Vitamin D-fortified milk', 'Vitamin D', 'Fortified milk can contribute vitamin D; check the label for the amount per serving.', 'Choose a suitable alternative for milk allergy and check that plant beverages are fortified.', 'https://ods.od.nih.gov/factsheets/VitaminD-HealthProfessional/'),
(2, 'Vitamin D-fortified soy beverage', 'Vitamin D', 'A fortified plant beverage can contribute vitamin D; check the label and shake before pouring if directed.', 'Fortification varies by product; do not take high-dose vitamin D supplements without clinical guidance.', 'https://ods.od.nih.gov/factsheets/VitaminD-HealthProfessional/'),
(3, 'Eggs', 'Vitamin B12', 'Provide vitamin B12 and protein.', 'Avoid if you have an egg allergy; eggs alone may not correct a confirmed deficiency.', 'https://ods.od.nih.gov/factsheets/VitaminB12-HealthProfessional/'),
(3, 'Milk or yogurt', 'Vitamin B12', 'Dairy foods provide vitamin B12 and can contribute protein and calcium.', 'Choose a suitable alternative if you have a milk allergy; most plant beverages need B12 fortification to provide it.', 'https://ods.od.nih.gov/factsheets/VitaminB12-HealthProfessional/'),
(3, 'Salmon', 'Vitamin B12', 'Provides vitamin B12 and protein.', 'Avoid if you have a fish allergy; follow local fish-safety advice.', 'https://ods.od.nih.gov/factsheets/VitaminB12-HealthProfessional/'),
(3, 'Vitamin B12-fortified breakfast cereal', 'Vitamin B12', 'Fortified cereal can provide B12; check the label and serving size.', 'Unfortified plant foods are not reliable sources of B12; people following vegan diets need a reliable fortified food or clinician-directed supplement.', 'https://ods.od.nih.gov/factsheets/VitaminB12-HealthProfessional/'),
(4, 'Carrots', 'Vitamin A', 'Provide beta-carotene, a provitamin A carotenoid.', 'No specific restriction is needed for most people; avoid relying on high-dose vitamin A supplements without clinical advice.', 'https://ods.od.nih.gov/factsheets/VitaminA-HealthProfessional/'),
(4, 'Cooked spinach', 'Vitamin A', 'Provides provitamin A carotenoids as part of a varied diet.', 'No specific restriction is needed for most people unless a clinician has advised otherwise.', 'https://ods.od.nih.gov/factsheets/VitaminA-HealthProfessional/'),
(4, 'Eggs', 'Vitamin A', 'Provide preformed vitamin A along with protein and other nutrients.', 'Avoid high-dose retinol supplements and frequent liver intake during pregnancy unless specifically directed by a clinician.', 'https://ods.od.nih.gov/factsheets/VitaminA-HealthProfessional/'),
(4, 'Sweet potato', 'Vitamin A', 'Provides beta-carotene, which the body can convert to vitamin A, along with fiber.', 'No specific restriction is needed for most people; food beta-carotene is not the same as high-dose retinol supplements.', 'https://ods.od.nih.gov/factsheets/VitaminA-HealthProfessional/'),
(5, 'Broccoli', 'Vitamin C', 'Provides vitamin C and fiber; brief cooking can reduce losses compared with prolonged boiling.', 'No specific restriction is needed for most people unless you have an allergy or clinician-directed restriction.', 'https://ods.od.nih.gov/factsheets/VitaminC-HealthProfessional/'),
(5, 'Kiwi', 'Vitamin C', 'Provides vitamin C and fiber.', 'Avoid if you have a kiwi allergy; choose another fruit if it causes oral irritation.', 'https://ods.od.nih.gov/factsheets/VitaminC-HealthProfessional/'),
(5, 'Orange', 'Vitamin C', 'Provides vitamin C and fluid as a whole fruit.', 'If citrus worsens reflux or irritation, choose another vitamin C-rich fruit or vegetable.', 'https://ods.od.nih.gov/factsheets/VitaminC-HealthProfessional/'),
(5, 'Red bell pepper', 'Vitamin C', 'Provides vitamin C; eating it raw or lightly cooked can help preserve vitamin C.', 'Avoid if you have an allergy or intolerance; no high-dose supplement is needed unless clinically advised.', 'https://ods.od.nih.gov/factsheets/VitaminC-HealthProfessional/'),
(6, 'Almonds', 'Vitamin E', 'Provide vitamin E, fiber, and unsaturated fats.', 'Avoid if you have a tree-nut allergy; high-dose vitamin E supplements can increase bleeding risk.', 'https://ods.od.nih.gov/factsheets/VitaminE-HealthProfessional/'),
(6, 'Avocado', 'Vitamin E', 'Provides vitamin E and unsaturated fats.', 'No specific restriction is needed for most people unless you have an allergy or clinician-directed dietary restriction.', 'https://ods.od.nih.gov/factsheets/VitaminE-HealthProfessional/'),
(6, 'Sunflower oil', 'Vitamin E', 'Provides vitamin E; use as one option among varied unsaturated oils.', 'Use appropriate portions and avoid repeatedly heating oil to smoking; avoid if you have a relevant allergy.', 'https://ods.od.nih.gov/factsheets/VitaminE-HealthProfessional/'),
(6, 'Sunflower seeds', 'Vitamin E', 'Provide vitamin E and unsaturated fats.', 'Avoid if you have a seed allergy; high-dose vitamin E supplements can interact with medicines and should be clinician-directed.', 'https://ods.od.nih.gov/factsheets/VitaminE-HealthProfessional/'),
(7, 'Broccoli', 'Vitamin K', 'Provides vitamin K1 and other nutrients.', 'If you take warfarin, do not make sudden large changes in intake without discussing them with your clinician.', 'https://ods.od.nih.gov/factsheets/VitaminK-HealthProfessional/'),
(7, 'Canola or soybean oil', 'Vitamin K', 'These oils can contribute vitamin K1; amounts vary by product and serving.', 'If you take warfarin, focus on consistent intake and seek clinician guidance before major dietary changes.', 'https://ods.od.nih.gov/factsheets/VitaminK-HealthProfessional/'),
(7, 'Kale', 'Vitamin K', 'Provides vitamin K1 and other nutrients.', 'If you take warfarin, keep vitamin K intake consistent and coordinate changes with your clinician rather than avoiding these foods.', 'https://ods.od.nih.gov/factsheets/VitaminK-HealthProfessional/'),
(7, 'Spinach', 'Vitamin K', 'Provides vitamin K1 as part of a varied diet.', 'If you take warfarin, maintain a consistent intake and follow your anticoagulation clinician\'s advice.', 'https://ods.od.nih.gov/factsheets/VitaminK-HealthProfessional/'),
(8, 'Black beans', 'Vitamin B1 (thiamin)', 'Provide thiamin, fiber, and plant protein.', 'No specific restriction is needed for most people; seek medical care for suspected deficiency rather than relying on food alone.', 'https://ods.od.nih.gov/factsheets/Thiamin-HealthProfessional/'),
(8, 'Pork', 'Vitamin B1 (thiamin)', 'Provides thiamin and protein.', 'Cook thoroughly and choose lean, minimally processed options when possible.', 'https://ods.od.nih.gov/factsheets/Thiamin-HealthProfessional/'),
(8, 'Thiamin-fortified breakfast cereal', 'Vitamin B1 (thiamin)', 'Fortified cereals can contribute thiamin; check the nutrition label for amounts.', 'Choose a lower-sugar option where practical; food changes do not replace urgent assessment for severe symptoms.', 'https://ods.od.nih.gov/factsheets/Thiamin-HealthProfessional/'),
(8, 'Whole-grain bread', 'Vitamin B1 (thiamin)', 'Whole grains can provide thiamin and fiber.', 'Check labels if you need a specific grain-free or gluten-free diet.', 'https://ods.od.nih.gov/factsheets/Thiamin-HealthProfessional/'),
(9, 'Eggs', 'Vitamin B2 (riboflavin)', 'Provide riboflavin and protein.', 'Avoid if you have an egg allergy; no other general restriction is needed.', 'https://ods.od.nih.gov/factsheets/Riboflavin-HealthProfessional/'),
(9, 'Milk or yogurt', 'Vitamin B2 (riboflavin)', 'Dairy foods provide riboflavin (vitamin B2) and other nutrients.', 'Choose a suitable alternative for milk allergy and check whether plant beverages are riboflavin-fortified.', 'https://ods.od.nih.gov/factsheets/Riboflavin-HealthProfessional/'),
(9, 'Mushrooms', 'Vitamin B2 (riboflavin)', 'Some mushroom varieties provide riboflavin and fiber.', 'Cook and store safely; avoid if you have a mushroom allergy or intolerance.', 'https://ods.od.nih.gov/factsheets/Riboflavin-HealthProfessional/'),
(9, 'Riboflavin-fortified cereal', 'Vitamin B2 (riboflavin)', 'Fortified cereal can contribute riboflavin; check the nutrition label.', 'Choose an option that fits your overall dietary needs; a confirmed deficiency may need clinical treatment.', 'https://ods.od.nih.gov/factsheets/Riboflavin-HealthProfessional/'),
(10, 'Brown rice', 'Vitamin B3 (niacin)', 'Provides niacin and whole-grain fiber.', 'Choose a suitable grain alternative if required; food sources do not replace care for a confirmed deficiency.', 'https://ods.od.nih.gov/factsheets/Niacin-HealthProfessional/'),
(10, 'Chicken', 'Vitamin B3 (niacin)', 'Provides niacin (vitamin B3) and protein.', 'Cook thoroughly and choose lean, minimally processed options when possible.', 'https://ods.od.nih.gov/factsheets/Niacin-HealthProfessional/'),
(10, 'Peanuts', 'Vitamin B3 (niacin)', 'Provide niacin along with protein and unsaturated fats.', 'Avoid if you have a peanut allergy; high-dose niacin supplements can cause harm and require medical supervision.', 'https://ods.od.nih.gov/factsheets/Niacin-HealthProfessional/'),
(10, 'Tuna', 'Vitamin B3 (niacin)', 'Provides niacin and protein.', 'Follow local advice on tuna frequency and mercury, especially during pregnancy; avoid if you have a fish allergy.', 'https://ods.od.nih.gov/factsheets/Niacin-HealthProfessional/'),
(11, 'Banana', 'Vitamin B6', 'Provides vitamin B6 and carbohydrate as a whole fruit.', 'No specific restriction is needed for most people; avoid prolonged high-dose B6 supplements unless prescribed.', 'https://ods.od.nih.gov/factsheets/VitaminB6-HealthProfessional/'),
(11, 'Chickpeas', 'Vitamin B6', 'Provide vitamin B6, fiber, and plant protein.', 'No specific restriction is needed for most people; avoid high-dose B6 supplements unless prescribed.', 'https://ods.od.nih.gov/factsheets/VitaminB6-HealthProfessional/'),
(11, 'Potatoes', 'Vitamin B6', 'Provide vitamin B6 and carbohydrate as part of a varied meal.', 'No specific restriction is needed for most people unless a clinician has advised otherwise.', 'https://ods.od.nih.gov/factsheets/VitaminB6-HealthProfessional/'),
(11, 'Salmon', 'Vitamin B6', 'Provides vitamin B6, protein, and omega-3 fats.', 'Avoid if you have a fish allergy; follow local fish-safety advice.', 'https://ods.od.nih.gov/factsheets/VitaminB6-HealthProfessional/'),
(12, 'Almonds', 'Biotin', 'Provide biotin along with unsaturated fats, protein, and vitamin E as part of a varied diet.', 'Avoid if you have a tree-nut allergy; no specific restriction is needed for most people.', 'https://ods.od.nih.gov/factsheets/Biotin-HealthProfessional/'),
(12, 'Eggs', 'Biotin', 'Cooked egg yolks provide biotin and protein; cooking also makes raw egg-white avidin less of a concern.', 'Avoid raw egg whites; cook eggs thoroughly. People with an egg allergy should avoid eggs.', 'https://ods.od.nih.gov/factsheets/Biotin-HealthProfessional/'),
(12, 'Salmon', 'Biotin', 'Provides biotin along with protein and omega-3 fats.', 'Avoid if you have a fish allergy; follow local food-safety advice for preparation.', 'https://ods.od.nih.gov/factsheets/Biotin-HealthProfessional/'),
(12, 'Spinach', 'Biotin', 'Provides a small amount of biotin as part of a varied diet, as well as folate and other nutrients.', 'No specific restriction is needed for most people unless you have an allergy or clinician-directed dietary restriction.', 'https://ods.od.nih.gov/factsheets/Biotin-HealthProfessional/'),
(12, 'Sweet Potatoes', 'Biotin', 'Provide biotin along with fiber and provitamin A carotenoids.', 'No specific restriction is needed for most people unless you have an allergy or clinician-directed dietary restriction.', 'https://ods.od.nih.gov/factsheets/Biotin-HealthProfessional/'),
(13, 'Asparagus', 'Folate', 'Provides folate and fiber.', 'No specific restriction is needed for most people unless you have an allergy.', 'https://ods.od.nih.gov/factsheets/Folate-HealthProfessional/'),
(13, 'Avocado', 'Folate', 'Provides folate and unsaturated fats.', 'No specific restriction is needed for most people unless you have an allergy.', 'https://ods.od.nih.gov/factsheets/Folate-HealthProfessional/'),
(13, 'Cooked spinach', 'Folate', 'Provides folate as part of a varied diet.', 'No specific restriction is needed for most people unless you have a clinician-directed dietary restriction.', 'https://ods.od.nih.gov/factsheets/Folate-HealthProfessional/'),
(13, 'Lentils', 'Folate', 'Provide folate, fiber, and plant protein.', 'No specific restriction is needed for most people; follow medical advice if you take medicines that affect folate.', 'https://ods.od.nih.gov/factsheets/Folate-HealthProfessional/'),
(14, 'Calcium-set tofu', 'Calcium', 'Can provide calcium and plant protein; calcium content depends on the coagulant and product label.', 'Check the label because tofu made with other coagulants may contain much less calcium.', 'https://ods.od.nih.gov/factsheets/Calcium-HealthProfessional/'),
(14, 'Milk or calcium-fortified soy beverage', 'Calcium', 'Provides calcium; fortified soy beverages can be a useful option when dairy is not used. Check the label for calcium content.', 'Shake fortified beverages before pouring and check labels, since calcium content varies; follow clinician advice if you have kidney disease.', 'https://ods.od.nih.gov/factsheets/Calcium-HealthProfessional/'),
(14, 'Plain yogurt', 'Calcium', 'Provides calcium and protein; choose a variety that fits your needs.', 'If you have a milk allergy, choose a suitable fortified alternative; lactose-free dairy may still provide calcium.', 'https://ods.od.nih.gov/factsheets/Calcium-HealthProfessional/'),
(14, 'Sardines with edible bones', 'Calcium', 'Provide calcium from edible bones as well as protein and vitamin D.', 'Choose lower-sodium options when needed; avoid if you have a fish allergy.', 'https://ods.od.nih.gov/factsheets/Calcium-HealthProfessional/'),
(15, 'Black beans', 'Magnesium', 'Provide magnesium along with fiber and plant protein.', 'No specific restriction is needed for most people; increase fiber gradually if needed.', 'https://ods.od.nih.gov/factsheets/Magnesium-HealthProfessional/'),
(15, 'Cooked spinach', 'Magnesium', 'Provides magnesium and folate as part of a varied diet.', 'No specific restriction is needed for most people unless a clinician has advised otherwise.', 'https://ods.od.nih.gov/factsheets/Magnesium-HealthProfessional/'),
(15, 'Oats', 'Magnesium', 'Provide magnesium and whole-grain fiber.', 'Choose certified gluten-free oats if required for celiac disease or gluten sensitivity.', 'https://ods.od.nih.gov/factsheets/Magnesium-HealthProfessional/'),
(15, 'Pumpkin seeds', 'Magnesium', 'Provide magnesium, plant protein, and unsaturated fats.', 'Avoid if you have a seed allergy; people with significant kidney disease should ask a clinician before using magnesium supplements.', 'https://ods.od.nih.gov/factsheets/Magnesium-HealthProfessional/'),
(16, 'Beef', 'Zinc', 'Provides zinc and protein.', 'Choose lean, unprocessed options and moderate portions; avoid if you have an allergy or dietary restriction.', 'https://ods.od.nih.gov/factsheets/Zinc-HealthProfessional/'),
(16, 'Chickpeas', 'Zinc', 'Provide zinc, fiber, and plant protein; soaking and thorough cooking can improve meal digestibility.', 'Plant phytates can reduce zinc absorption, so include a varied diet; do not use high-dose zinc supplements without clinical advice.', 'https://ods.od.nih.gov/factsheets/Zinc-HealthProfessional/'),
(16, 'Cooked oysters', 'Zinc', 'Provide zinc; amounts can be high and vary by species and serving.', 'Avoid raw oysters because of foodborne illness risk; avoid if you have a shellfish allergy.', 'https://ods.od.nih.gov/factsheets/Zinc-HealthProfessional/'),
(16, 'Pumpkin seeds', 'Zinc', 'Provide zinc, plant protein, and unsaturated fats.', 'Avoid if you have a seed allergy; high-dose zinc supplements can cause copper deficiency.', 'https://ods.od.nih.gov/factsheets/Zinc-HealthProfessional/'),
(17, 'Cashews', 'Copper', 'Provide copper along with unsaturated fats and protein.', 'Avoid if you have a tree-nut allergy; people with Wilson disease should follow specialist advice about copper-rich foods.', 'https://ods.od.nih.gov/factsheets/Copper-HealthProfessional/'),
(17, 'Chickpeas', 'Copper', 'Provide copper and plant protein in a versatile legume.', 'No specific restriction is needed for most people; increase fiber-rich foods gradually if they cause digestive discomfort.', 'https://ods.od.nih.gov/factsheets/Copper-HealthProfessional/'),
(17, 'Cooked oysters', 'Copper', 'A concentrated food source of copper, as well as protein and other minerals.', 'Avoid raw oysters because of foodborne illness risk; if you have Wilson disease or a copper restriction, follow specialist advice.', 'https://ods.od.nih.gov/factsheets/Copper-HealthProfessional/'),
(17, 'Sunflower seeds', 'Copper', 'Provide copper, unsaturated fats, and other minerals.', 'Avoid if you have a seed allergy; people with Wilson disease should follow specialist advice about copper-rich foods.', 'https://ods.od.nih.gov/factsheets/Copper-HealthProfessional/'),
(18, 'Cod', 'Iodine', 'Provides iodine and protein; iodine content varies by species and source.', 'Avoid if you have a fish allergy; follow clinician guidance for thyroid conditions.', 'https://ods.od.nih.gov/factsheets/Iodine-HealthProfessional/'),
(18, 'Eggs', 'Iodine', 'Provide iodine and protein; content varies with production and serving size.', 'Avoid if you have an egg allergy; do not use seaweed or iodine supplements as a substitute for clinical advice.', 'https://ods.od.nih.gov/factsheets/Iodine-HealthProfessional/'),
(18, 'Iodized salt', 'Iodine', 'A reliable source of iodine when used in place of non-iodized salt; use modest amounts.', 'Do not increase salt intake to obtain iodine. Ask a clinician about iodine intake if you have thyroid disease or are pregnant.', 'https://ods.od.nih.gov/factsheets/Iodine-HealthProfessional/'),
(18, 'Milk or yogurt', 'Iodine', 'Dairy foods can contribute iodine as well as protein or calcium; levels vary by product and region.', 'Choose a suitable alternative if you have a milk allergy; plant beverages are not necessarily iodine-fortified.', 'https://ods.od.nih.gov/factsheets/Iodine-HealthProfessional/'),
(19, 'Chicken', 'Selenium', 'Provides selenium and protein.', 'Cook thoroughly and follow food-safety guidance; no specific restriction is needed for most people.', 'https://ods.od.nih.gov/factsheets/Selenium-HealthProfessional/'),
(19, 'Cooked fish', 'Selenium', 'Fish such as tuna can provide selenium and protein; levels vary by species.', 'Follow local advice about fish choices and mercury, especially during pregnancy; avoid if you have a fish allergy.', 'https://ods.od.nih.gov/factsheets/Selenium-HealthProfessional/'),
(19, 'Eggs', 'Selenium', 'Provide selenium and protein as part of a varied diet.', 'Avoid if you have an egg allergy; no special restriction is needed for most people.', 'https://ods.od.nih.gov/factsheets/Selenium-HealthProfessional/'),
(19, 'Whole-grain bread', 'Selenium', 'Can contribute selenium, though amounts vary with growing conditions and ingredients.', 'Choose an option that fits any allergy, celiac, or other clinician-directed dietary needs.', 'https://ods.od.nih.gov/factsheets/Selenium-HealthProfessional/'),
(20, 'Baked potato with skin', 'Potassium', 'Provides potassium and fiber.', 'If you have kidney disease or take medicines that raise potassium, ask your clinician before increasing potassium-rich foods.', 'https://ods.od.nih.gov/factsheets/Potassium-HealthProfessional/'),
(20, 'Banana', 'Potassium', 'Provides potassium and carbohydrate in a convenient whole fruit.', 'If you have kidney disease or take medicines that raise potassium, ask your clinician before increasing intake.', 'https://ods.od.nih.gov/factsheets/Potassium-HealthProfessional/'),
(20, 'Plain yogurt', 'Potassium', 'Provides potassium and protein; amounts vary by product.', 'Choose a suitable alternative for milk allergy; ask a clinician before increasing potassium if you have kidney disease or relevant medicines.', 'https://ods.od.nih.gov/factsheets/Potassium-HealthProfessional/'),
(20, 'White beans', 'Potassium', 'Provide potassium, plant protein, and fiber.', 'If you have kidney disease or take medicines that raise potassium, seek individualized advice before increasing intake.', 'https://ods.od.nih.gov/factsheets/Potassium-HealthProfessional/');

-- --------------------------------------------------------

--
-- Table structure for table `stage_gene_associations`
--

CREATE TABLE `stage_gene_associations` (
  `association_id` int(11) NOT NULL,
  `deficiency_id` int(11) NOT NULL,
  `gene_symbol` varchar(30) NOT NULL,
  `gene_id` int(11) NOT NULL,
  `gene_name` varchar(255) NOT NULL,
  `association_description` text NOT NULL,
  `source_url` varchar(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stage_gene_associations`
--

INSERT INTO `stage_gene_associations` (`association_id`, `deficiency_id`, `gene_symbol`, `gene_id`, `gene_name`, `association_description`, `source_url`) VALUES
(1, 1, 'HFE', 3077, 'Homeostatic Iron Regulator', 'Participates in iron sensing and regulation; variation can affect iron homeostasis, but the association does not establish nutritional deficiency.', 'https://www.ncbi.nlm.nih.gov/gene/3077'),
(2, 1, 'TF', 7018, 'Transferrin', 'Encodes transferrin, which transports iron in blood; this function is relevant to iron physiology but does not show that low dietary iron is gene-caused.', 'https://www.ncbi.nlm.nih.gov/gene/7018'),
(3, 1, 'TFR2', 7036, 'Transferrin Receptor 2', 'Encodes transferrin receptor 2, involved in iron sensing and regulation of hepcidin; this is a biological pathway association, not a diagnosis.', 'https://www.ncbi.nlm.nih.gov/gene/7036'),
(4, 1, 'SLC40A1', 30061, 'Ferroportin', 'Encodes ferroportin, a cellular iron exporter involved in iron transport; the association is mechanistic and not a diagnosis.', 'https://www.ncbi.nlm.nih.gov/gene/30061'),
(5, 1, 'HAMP', 57817, 'Hepcidin Antimicrobial Peptide', 'Encodes hepcidin, a hormone that regulates systemic iron availability and iron export; this is a biological iron-homeostasis relationship, not proof that dietary iron deficiency is caused by this gene.', 'https://www.ncbi.nlm.nih.gov/gene/57817');

-- --------------------------------------------------------

--
-- Table structure for table `stage_pathway_associations`
--

CREATE TABLE `stage_pathway_associations` (
  `association_id` int(11) NOT NULL,
  `deficiency_id` int(11) NOT NULL,
  `pathway_name` varchar(255) NOT NULL,
  `pathway_id` varchar(100) NOT NULL DEFAULT '',
  `pathway_description` text NOT NULL,
  `source_url` varchar(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stage_pathway_associations`
--

INSERT INTO `stage_pathway_associations` (`association_id`, `deficiency_id`, `pathway_name`, `pathway_id`, `pathway_description`, `source_url`) VALUES
(1, 1, 'Iron Homeostasis', '', 'Biological process label exported from the existing application database. Exact Reactome pathway correspondence and identifier have not been independently established.', 'https://reactome.org/'),
(2, 1, 'HIF-1 Signaling Pathway', '', 'Pathway label exported from the existing application database. Exact Reactome pathway correspondence and identifier have not been independently established.', 'https://reactome.org/'),
(3, 1, 'Erythropoiesis', '', 'Biological process label exported from the existing application database. Exact Reactome pathway correspondence and identifier have not been independently established.', 'https://reactome.org/'),
(4, 1, 'Cellular Iron Uptake', '', 'Pathway label exported from the existing application database. Exact Reactome pathway correspondence and identifier have not been independently established.', 'https://reactome.org/');

-- --------------------------------------------------------

--
-- Table structure for table `stage_protein_associations`
--

CREATE TABLE `stage_protein_associations` (
  `association_id` int(11) NOT NULL,
  `deficiency_id` int(11) NOT NULL,
  `protein_name` varchar(255) NOT NULL,
  `uniprot_accession` varchar(20) NOT NULL,
  `protein_function` text NOT NULL,
  `association_description` text NOT NULL,
  `source_url` varchar(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stage_protein_associations`
--

INSERT INTO `stage_protein_associations` (`association_id`, `deficiency_id`, `protein_name`, `uniprot_accession`, `protein_function`, `association_description`, `source_url`) VALUES
(1, 1, 'Ferritin heavy chain', 'P02794', 'Ferritin stores iron intracellularly and helps manage iron availability.', 'Biological iron-related function is provided as context only; this association does not establish a cause or diagnosis of nutritional deficiency.', 'https://www.uniprot.org/uniprotkb/P02794'),
(2, 1, 'Transferrin', 'P02787', 'Transferrin binds and transports iron in blood.', 'Biological iron-related function is provided as context only; this association does not establish a cause or diagnosis of nutritional deficiency.', 'https://www.uniprot.org/uniprotkb/P02787'),
(3, 1, 'Transferrin receptor 2', 'Q9UP52', 'Transferrin receptor 2 participates in cellular iron sensing and regulation.', 'Biological iron-related function is provided as context only; this association does not establish a cause or diagnosis of nutritional deficiency.', 'https://www.uniprot.org/uniprotkb/Q9UP52'),
(4, 1, 'Ferroportin', 'Q9NP59', 'Ferroportin exports iron from cells and is encoded by SLC40A1.', 'Biological iron-related function is provided as context only; this association does not establish a cause or diagnosis of nutritional deficiency.', 'https://www.uniprot.org/uniprotkb/Q9NP59'),
(5, 1, 'Hepcidin', 'P81172', 'Hepcidin is a peptide hormone that regulates iron export and systemic iron availability.', 'Biological iron-related function is provided as context only; this association does not establish a cause or diagnosis of nutritional deficiency.', 'https://www.uniprot.org/uniprotkb/P81172');

-- --------------------------------------------------------

--
-- Table structure for table `stage_symptom_master`
--

CREATE TABLE `stage_symptom_master` (
  `symptom_id` int(11) NOT NULL,
  `symptom_name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `source_url` varchar(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stage_symptom_master`
--

INSERT INTO `stage_symptom_master` (`symptom_id`, `symptom_name`, `description`, `source_url`) VALUES
(1, 'Fatigue', 'Feeling unusually tired or lacking energy; nonspecific and may have many causes.', 'https://medlineplus.gov/symptoms.html'),
(2, 'Weakness', 'Reduced strength; nonspecific and may have many causes.', 'https://medlineplus.gov/symptoms.html'),
(3, 'Hair Loss', 'Increased hair shedding or loss; has many possible causes.', 'https://medlineplus.gov/symptoms.html'),
(4, 'Pale Skin', 'Paler-than-usual skin appearance; has many possible causes.', 'https://medlineplus.gov/symptoms.html'),
(5, 'Bone Pain', 'Pain felt in bone; has many possible causes and requires appropriate assessment.', 'https://medlineplus.gov/symptoms.html'),
(6, 'Muscle Cramps', 'Sudden involuntary muscle contraction; has many possible causes.', 'https://medlineplus.gov/symptoms.html'),
(7, 'Dry Skin', 'Dry or rough skin; has many possible causes.', 'https://medlineplus.gov/symptoms.html'),
(8, 'Night Blindness', 'Difficulty seeing in low light; requires professional assessment.', 'https://medlineplus.gov/symptoms.html'),
(9, 'Bleeding Gums', 'Bleeding from the gums; dental and other causes are common.', 'https://medlineplus.gov/symptoms.html'),
(10, 'Mouth Ulcers', 'Sores inside the mouth; have many possible causes.', 'https://medlineplus.gov/symptoms.html'),
(11, 'Numbness', 'Reduced or altered sensation; cause and urgency depend on the situation.', 'https://medlineplus.gov/symptoms.html'),
(12, 'Dizziness', 'A feeling of faintness, unsteadiness, or motion; has many possible causes.', 'https://medlineplus.gov/symptoms.html'),
(13, 'Poor Wound Healing', 'A wound healing more slowly than expected; has many possible causes.', 'https://medlineplus.gov/symptoms.html'),
(14, 'Frequent Infections', 'Repeated infections; a nonspecific finding that warrants context.', 'https://medlineplus.gov/symptoms.html'),
(15, 'Loss of Appetite', 'Reduced desire to eat; has many possible causes.', 'https://medlineplus.gov/symptoms.html'),
(16, 'Depression', 'Persistent low mood or loss of interest; requires appropriate mental-health assessment.', 'https://medlineplus.gov/symptoms.html'),
(17, 'Brittle Nails', 'Nails that split, peel, or break easily; has many possible causes.', 'https://medlineplus.gov/symptoms.html'),
(18, 'Shortness of Breath', 'Breathing discomfort or difficulty; may require urgent medical attention.', 'https://medlineplus.gov/symptoms.html'),
(19, 'Headache', 'Pain or discomfort in the head; has many possible causes.', 'https://medlineplus.gov/symptoms.html'),
(20, 'Weight Loss', 'Unintended decrease in body weight; has many possible causes.', 'https://medlineplus.gov/symptoms.html');

-- --------------------------------------------------------

--
-- Table structure for table `symptom_master`
--

CREATE TABLE `symptom_master` (
  `symptom_id` int(11) NOT NULL,
  `symptom_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `symptom_master`
--

INSERT INTO `symptom_master` (`symptom_id`, `symptom_name`) VALUES
(1, 'Fatigue'),
(2, 'Weakness'),
(3, 'Hair Loss'),
(4, 'Pale Skin'),
(5, 'Bone Pain'),
(6, 'Muscle Cramps'),
(7, 'Dry Skin'),
(8, 'Night Blindness'),
(9, 'Bleeding Gums'),
(10, 'Mouth Ulcers'),
(11, 'Numbness'),
(12, 'Dizziness'),
(13, 'Poor Wound Healing'),
(14, 'Frequent Infections'),
(15, 'Loss of Appetite'),
(16, 'Depression'),
(17, 'Brittle Nails'),
(18, 'Shortness of Breath'),
(19, 'Headache'),
(20, 'Weight Loss');

-- --------------------------------------------------------

--
-- Table structure for table `symptom_metadata`
--

CREATE TABLE `symptom_metadata` (
  `symptom_id` int(11) NOT NULL,
  `description` text NOT NULL,
  `source_url` varchar(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `symptom_metadata`
--

INSERT INTO `symptom_metadata` (`symptom_id`, `description`, `source_url`) VALUES
(1, 'Feeling unusually tired or lacking energy; nonspecific and may have many causes.', 'https://medlineplus.gov/symptoms.html'),
(2, 'Reduced strength; nonspecific and may have many causes.', 'https://medlineplus.gov/symptoms.html'),
(3, 'Increased hair shedding or loss; has many possible causes.', 'https://medlineplus.gov/symptoms.html'),
(4, 'Paler-than-usual skin appearance; has many possible causes.', 'https://medlineplus.gov/symptoms.html'),
(5, 'Pain felt in bone; has many possible causes and requires appropriate assessment.', 'https://medlineplus.gov/symptoms.html'),
(6, 'Sudden involuntary muscle contraction; has many possible causes.', 'https://medlineplus.gov/symptoms.html'),
(7, 'Dry or rough skin; has many possible causes.', 'https://medlineplus.gov/symptoms.html'),
(8, 'Difficulty seeing in low light; requires professional assessment.', 'https://medlineplus.gov/symptoms.html'),
(9, 'Bleeding from the gums; dental and other causes are common.', 'https://medlineplus.gov/symptoms.html'),
(10, 'Sores inside the mouth; have many possible causes.', 'https://medlineplus.gov/symptoms.html'),
(11, 'Reduced or altered sensation; cause and urgency depend on the situation.', 'https://medlineplus.gov/symptoms.html'),
(12, 'A feeling of faintness, unsteadiness, or motion; has many possible causes.', 'https://medlineplus.gov/symptoms.html'),
(13, 'A wound healing more slowly than expected; has many possible causes.', 'https://medlineplus.gov/symptoms.html'),
(14, 'Repeated infections; a nonspecific finding that warrants context.', 'https://medlineplus.gov/symptoms.html'),
(15, 'Reduced desire to eat; has many possible causes.', 'https://medlineplus.gov/symptoms.html'),
(16, 'Persistent low mood or loss of interest; requires appropriate mental-health assessment.', 'https://medlineplus.gov/symptoms.html'),
(17, 'Nails that split, peel, or break easily; has many possible causes.', 'https://medlineplus.gov/symptoms.html'),
(18, 'Breathing discomfort or difficulty; may require urgent medical attention.', 'https://medlineplus.gov/symptoms.html'),
(19, 'Pain or discomfort in the head; has many possible causes.', 'https://medlineplus.gov/symptoms.html'),
(20, 'Unintended decrease in body weight; has many possible causes.', 'https://medlineplus.gov/symptoms.html');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `created_at`) VALUES
(1, 'Nithya shree', 'nithikrish2028@gmail.com', '$2y$10$OL1n3Lez/jxpN7t1fwxu4OZofg/qAmMydHtbtVsPwMnc99lGRbwGK', '2026-10-04 09:46:20'),
(2, 'nithyashree', 'nithyashreesk2028@gmail.com', '$2y$10$ZZqj2LWu8O2ZykfsdOatCe6OSf6UECBHDZ48Y7V09qvhkxaCqIU4C', '2026-10-10 14:10:14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `analyses`
--
ALTER TABLE `analyses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `compound_data`
--
ALTER TABLE `compound_data`
  ADD PRIMARY KEY (`compound_id`),
  ADD UNIQUE KEY `uq_compound_pubchem_cid` (`pubchem_cid`),
  ADD KEY `ix_compound_related_nutrient` (`related_nutrient`);

--
-- Indexes for table `dataset_sources`
--
ALTER TABLE `dataset_sources`
  ADD PRIMARY KEY (`source_id`);

--
-- Indexes for table `deficiency_master`
--
ALTER TABLE `deficiency_master`
  ADD PRIMARY KEY (`deficiency_id`);

--
-- Indexes for table `deficiency_metadata`
--
ALTER TABLE `deficiency_metadata`
  ADD PRIMARY KEY (`deficiency_id`);

--
-- Indexes for table `deficiency_symptoms`
--
ALTER TABLE `deficiency_symptoms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_deficiency_symptom_pair` (`deficiency_id`,`symptom_id`),
  ADD KEY `fk_deficiency_symptoms_symptom` (`symptom_id`);

--
-- Indexes for table `deficiency_symptom_metadata`
--
ALTER TABLE `deficiency_symptom_metadata`
  ADD PRIMARY KEY (`deficiency_id`,`symptom_id`),
  ADD KEY `fk_deficiency_symptom_metadata_symptom` (`symptom_id`);

--
-- Indexes for table `family_history_factors`
--
ALTER TABLE `family_history_factors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `deficiency_id` (`deficiency_id`);

--
-- Indexes for table `food_nutrient_data`
--
ALTER TABLE `food_nutrient_data`
  ADD PRIMARY KEY (`food_record_id`),
  ADD UNIQUE KEY `uq_food_nutrient_fdc_nutrient` (`fdc_id`,`nutrient_name`),
  ADD KEY `ix_food_nutrient_name` (`nutrient_name`),
  ADD KEY `ix_food_nutrient_fdc_id` (`fdc_id`);

--
-- Indexes for table `food_recommendations`
--
ALTER TABLE `food_recommendations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `deficiency_id` (`deficiency_id`);

--
-- Indexes for table `food_recommendation_metadata`
--
ALTER TABLE `food_recommendation_metadata`
  ADD PRIMARY KEY (`food_recommendation_id`);

--
-- Indexes for table `gene_associations`
--
ALTER TABLE `gene_associations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `deficiency_id` (`deficiency_id`);

--
-- Indexes for table `gene_association_metadata`
--
ALTER TABLE `gene_association_metadata`
  ADD PRIMARY KEY (`association_id`);

--
-- Indexes for table `lifestyle_factors`
--
ALTER TABLE `lifestyle_factors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `deficiency_id` (`deficiency_id`);

--
-- Indexes for table `lifestyle_recommendations`
--
ALTER TABLE `lifestyle_recommendations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_lifestyle_deficiency` (`deficiency_id`,`active`);

--
-- Indexes for table `pathway_associations`
--
ALTER TABLE `pathway_associations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `deficiency_id` (`deficiency_id`);

--
-- Indexes for table `pathway_association_citations`
--
ALTER TABLE `pathway_association_citations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_pathway_pmid` (`pathway_association_id`,`pmid`);

--
-- Indexes for table `pathway_association_metadata`
--
ALTER TABLE `pathway_association_metadata`
  ADD PRIMARY KEY (`association_id`);

--
-- Indexes for table `protein_associations`
--
ALTER TABLE `protein_associations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `deficiency_id` (`deficiency_id`);

--
-- Indexes for table `protein_association_metadata`
--
ALTER TABLE `protein_association_metadata`
  ADD PRIMARY KEY (`association_id`);

--
-- Indexes for table `stage_dataset_sources`
--
ALTER TABLE `stage_dataset_sources`
  ADD PRIMARY KEY (`source_id`);

--
-- Indexes for table `stage_deficiency_master`
--
ALTER TABLE `stage_deficiency_master`
  ADD PRIMARY KEY (`deficiency_id`);

--
-- Indexes for table `stage_deficiency_symptoms`
--
ALTER TABLE `stage_deficiency_symptoms`
  ADD PRIMARY KEY (`deficiency_id`,`symptom_id`);

--
-- Indexes for table `stage_food_recommendations`
--
ALTER TABLE `stage_food_recommendations`
  ADD PRIMARY KEY (`deficiency_id`,`food_name`);

--
-- Indexes for table `stage_gene_associations`
--
ALTER TABLE `stage_gene_associations`
  ADD PRIMARY KEY (`association_id`);

--
-- Indexes for table `stage_pathway_associations`
--
ALTER TABLE `stage_pathway_associations`
  ADD PRIMARY KEY (`association_id`);

--
-- Indexes for table `stage_protein_associations`
--
ALTER TABLE `stage_protein_associations`
  ADD PRIMARY KEY (`association_id`);

--
-- Indexes for table `stage_symptom_master`
--
ALTER TABLE `stage_symptom_master`
  ADD PRIMARY KEY (`symptom_id`);

--
-- Indexes for table `symptom_master`
--
ALTER TABLE `symptom_master`
  ADD PRIMARY KEY (`symptom_id`);

--
-- Indexes for table `symptom_metadata`
--
ALTER TABLE `symptom_metadata`
  ADD PRIMARY KEY (`symptom_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `analyses`
--
ALTER TABLE `analyses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `deficiency_master`
--
ALTER TABLE `deficiency_master`
  MODIFY `deficiency_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `deficiency_symptoms`
--
ALTER TABLE `deficiency_symptoms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `family_history_factors`
--
ALTER TABLE `family_history_factors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `food_recommendations`
--
ALTER TABLE `food_recommendations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `gene_associations`
--
ALTER TABLE `gene_associations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `lifestyle_factors`
--
ALTER TABLE `lifestyle_factors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `lifestyle_recommendations`
--
ALTER TABLE `lifestyle_recommendations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `pathway_associations`
--
ALTER TABLE `pathway_associations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `pathway_association_citations`
--
ALTER TABLE `pathway_association_citations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `protein_associations`
--
ALTER TABLE `protein_associations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `symptom_master`
--
ALTER TABLE `symptom_master`
  MODIFY `symptom_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `analyses`
--
ALTER TABLE `analyses`
  ADD CONSTRAINT `analyses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `deficiency_metadata`
--
ALTER TABLE `deficiency_metadata`
  ADD CONSTRAINT `fk_deficiency_metadata_master` FOREIGN KEY (`deficiency_id`) REFERENCES `deficiency_master` (`deficiency_id`);

--
-- Constraints for table `deficiency_symptoms`
--
ALTER TABLE `deficiency_symptoms`
  ADD CONSTRAINT `fk_deficiency_symptoms_deficiency` FOREIGN KEY (`deficiency_id`) REFERENCES `deficiency_master` (`deficiency_id`),
  ADD CONSTRAINT `fk_deficiency_symptoms_symptom` FOREIGN KEY (`symptom_id`) REFERENCES `symptom_master` (`symptom_id`);

--
-- Constraints for table `deficiency_symptom_metadata`
--
ALTER TABLE `deficiency_symptom_metadata`
  ADD CONSTRAINT `fk_deficiency_symptom_metadata_deficiency` FOREIGN KEY (`deficiency_id`) REFERENCES `deficiency_master` (`deficiency_id`),
  ADD CONSTRAINT `fk_deficiency_symptom_metadata_symptom` FOREIGN KEY (`symptom_id`) REFERENCES `symptom_master` (`symptom_id`);

--
-- Constraints for table `family_history_factors`
--
ALTER TABLE `family_history_factors`
  ADD CONSTRAINT `family_history_factors_ibfk_1` FOREIGN KEY (`deficiency_id`) REFERENCES `deficiency_master` (`deficiency_id`);

--
-- Constraints for table `food_recommendations`
--
ALTER TABLE `food_recommendations`
  ADD CONSTRAINT `food_recommendations_ibfk_1` FOREIGN KEY (`deficiency_id`) REFERENCES `deficiency_master` (`deficiency_id`);

--
-- Constraints for table `food_recommendation_metadata`
--
ALTER TABLE `food_recommendation_metadata`
  ADD CONSTRAINT `fk_food_metadata_recommendation` FOREIGN KEY (`food_recommendation_id`) REFERENCES `food_recommendations` (`id`);

--
-- Constraints for table `gene_associations`
--
ALTER TABLE `gene_associations`
  ADD CONSTRAINT `gene_associations_ibfk_1` FOREIGN KEY (`deficiency_id`) REFERENCES `deficiency_master` (`deficiency_id`);

--
-- Constraints for table `gene_association_metadata`
--
ALTER TABLE `gene_association_metadata`
  ADD CONSTRAINT `fk_gene_metadata_association` FOREIGN KEY (`association_id`) REFERENCES `gene_associations` (`id`);

--
-- Constraints for table `lifestyle_factors`
--
ALTER TABLE `lifestyle_factors`
  ADD CONSTRAINT `lifestyle_factors_ibfk_1` FOREIGN KEY (`deficiency_id`) REFERENCES `deficiency_master` (`deficiency_id`);

--
-- Constraints for table `lifestyle_recommendations`
--
ALTER TABLE `lifestyle_recommendations`
  ADD CONSTRAINT `fk_lifestyle_deficiency` FOREIGN KEY (`deficiency_id`) REFERENCES `deficiency_master` (`deficiency_id`);

--
-- Constraints for table `pathway_associations`
--
ALTER TABLE `pathway_associations`
  ADD CONSTRAINT `pathway_associations_ibfk_1` FOREIGN KEY (`deficiency_id`) REFERENCES `deficiency_master` (`deficiency_id`);

--
-- Constraints for table `pathway_association_citations`
--
ALTER TABLE `pathway_association_citations`
  ADD CONSTRAINT `fk_pathway_citation_association` FOREIGN KEY (`pathway_association_id`) REFERENCES `pathway_associations` (`id`);

--
-- Constraints for table `pathway_association_metadata`
--
ALTER TABLE `pathway_association_metadata`
  ADD CONSTRAINT `fk_pathway_metadata_association` FOREIGN KEY (`association_id`) REFERENCES `pathway_associations` (`id`);

--
-- Constraints for table `protein_associations`
--
ALTER TABLE `protein_associations`
  ADD CONSTRAINT `protein_associations_ibfk_1` FOREIGN KEY (`deficiency_id`) REFERENCES `deficiency_master` (`deficiency_id`);

--
-- Constraints for table `protein_association_metadata`
--
ALTER TABLE `protein_association_metadata`
  ADD CONSTRAINT `fk_protein_metadata_association` FOREIGN KEY (`association_id`) REFERENCES `protein_associations` (`id`);

--
-- Constraints for table `symptom_metadata`
--
ALTER TABLE `symptom_metadata`
  ADD CONSTRAINT `fk_symptom_metadata_master` FOREIGN KEY (`symptom_id`) REFERENCES `symptom_master` (`symptom_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
