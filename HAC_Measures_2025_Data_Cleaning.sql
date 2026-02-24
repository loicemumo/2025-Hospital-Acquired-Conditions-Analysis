CREATE DATABASE CMS_Hospital_Acquired_Conditions;
USE CMS_Hospital_Acquired_Conditions;

-- Imported dataset via MySQL GUI, with exception of Footnote column -- 
-- Create staging table for data cleaning purposes --
CREATE TABLE HAC_Measures_Staging AS SELECT * FROM hac_measure_provider_file_2025_raw;

-- Preview the dataset --
SELECT * FROM HAC_Measures_Staging
LIMIT 20;

/*
Issues noted in dataset preview;
	- Standardize entries in Measure column to short, consistent labels
    - A lot of 0 entries in Rate columns - confirmed to be no cases reported and not missing data
    - Drop the Start_Quarter and End_Quarter columns since they're unnecessary
*/

-- Drop unnecessary columns --
ALTER TABLE HAC_Measures_Staging
DROP COLUMN Start_Quarter,
DROP COLUMN END_Quarter;

-- Check for duplicates --
-- Use a CTE to check for rows that are duplicated --

-- CTE to number each row in the dataset --
WITH Numbered_Rows AS (
SELECT Provider_ID, Measure, Start_Quarter, End_Quarter, Rate,
       ROW_NUMBER() OVER (
         PARTITION BY Provider_ID, Measure, Start_Quarter, End_Quarter
         ORDER BY Provider_ID
       ) AS Row_Num
FROM HAC_Measures_Staging)
-- Retrieve only rows where Row_Num > 1 in above CTE --
SELECT * FROM Numbered_Rows
WHERE Row_Num > 1;

-- Query returned 0 rows so the dataset doesn't have duplicates --

-- Standardize data entries in Measures column--
-- Deactivate safe update mode --
SET SQL_SAFE_UPDATES = 0;

-- Update the measure column --
UPDATE HAC_Measures_Staging
SET Measure = 'Falls and Trauma'
WHERE Measure LIKE '%Falls and Trauma%'; 

-- Create a clean view for analysis --
CREATE VIEW HAC_Measures_Clean AS
SELECT 
    Provider_ID,
    Measure,
    Rate
FROM HAC_Measures_Staging;
