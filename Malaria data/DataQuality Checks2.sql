USE PRACTICE1;

SELECT * from malaria_data1;

SELECT COUNT(DISTINCT(column1)) FROM malaria_data;

SELECT DISTINCT(column1) FROM malaria_data;

--Counting the total Number of Columns Present
SELECT COUNT(*) AS NumberOfColumns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'malaria_data1'



--Renaming Columns

EXEC sp_rename 'malaria_data.[column1]',  'Region', 'COLUMN';
EXEC sp_rename 'malaria_data.[column2]',  'District', 'COLUMN';

EXEC sp_rename 'malaria_data1.[0-28_DAYS_Female]',  '0_28Days_Female', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_0_28_DAYS_MALE]',  '0_28Days_Male', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_0_28_DAYS_TOTAL]',  '0_28Days_Total', 'COLUMN';

EXEC sp_rename 'malaria_data1.[_10_19_YEARS_FEMALE]',  '10_19Days_Female', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_10_19_YEARS_MALE]',  '10_19Days_Male', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_10_19YRS_TOTAL]',  '10_19Days_Total', 'COLUMN';

EXEC sp_rename 'malaria_data1.[_20_YRS_FEMALE]',  '20+YRS_Female', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_20_YRS_MALE]', '20+YRS_Male', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_20_YRS_TOTAL]', '20+YRS_Total', 'COLUMN';

EXEC sp_rename 'malaria_data1.[_5_9YRS_FEMALE]', '5_9YRS_Female', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_5_9YRS_MALE]', '5_9YRS_Male', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_5_9YRS_TOTAL]', '5_9YRS_Total', 'COLUMN';

EXEC sp_rename 'malaria_data1.[_29_DAYS_4YRS_FEMALE]', '29Days_4Yrs_Female', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_29DAYS_4YRS_MALE]', '29Days_4Yrs_Male', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_29_DAYS_4YRS_TOTAL]', '29Days_4Yrs_Total', 'COLUMN';

EXEC sp_rename 'malaria_data1.[_]', '0_28Days(BSRDT)_Female', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_0_28_DAYS_B_S_RDT_MALE]', '0_28Days(BSRDT)_Male', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_0_28_DAYS_B_S_RDT_TOTAL]', '0_28Days(BSRDT)_Total', 'COLUMN';

EXEC sp_rename 'malaria_data1.[_10_19_YRS_B_S_RDT_FEMALE]', '10_19YRS(BSRDT)_Female', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_10_19_YRS_B_S_RDT_MALE]', '10_19YRS(BSRDT)_Male', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_10_19_YRS_B_S_RDT_TOTAL]', '10_19YRS(BSRDT)_Total', 'COLUMN';

EXEC sp_rename 'malaria_data1.[_20_B_S_RDT_FEMALE]', '20+YRS_(BSRDT)_Female', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_20_B_S_RDT_MALE]', '20+YRS_(BSRDT)_Male', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_20_B_S_RDT_TOTAL]', '20+YRS_(BSRDT)_Total', 'COLUMN';

EXEC sp_rename 'malaria_data1.[_29DAYS_4YRS_B_S_RDT_FEMALE]', '29Days_4Yrs(BSRDT)_Female', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_29DAYS_4YRS_B_S_RDT_MALE]', '29Days_4Yrs(BSRDT)_Male', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_29DAYS_4_YRS_B_S_RDT_TOTAL]', '29Days_4Yrs(BSRDT)_Total', 'COLUMN';

EXEC sp_rename 'malaria_data1.[_5_9YRS_B_S_RDT_FEMALE]', '5_9YRS(BSRDT)_Female', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_5_9YRS_B_S_RDT_MALE]', '5_9YRS(BSRDT)_Male', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_5_9YRS_B_S_RDT_TOTAL]', '5_9YRS(BSRDT)_Total', 'COLUMN';

EXEC sp_rename 'malaria_data1.[TOTAL_CASES_CONFIRMED_B_S_RDT]', 'TotalCasesConfirmed_BSRDT', 'COLUMN';

EXEC sp_rename 'malaria_data1.[_0_28_DAYS_FEMALE_CT]', '0_28Days_CT_Female', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_0_28_DAYS_MALE_CT]', '0_28Days_CT_Male', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_0_28_DAYS_TOTAL_CT]', '0_28Days_CT_Total', 'COLUMN';

EXEC sp_rename 'malaria_data1.[_10_19_YRS_FEMALE_CT]', '10_19YRS_CT_Female', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_10_19_YRS_MALE_CT]', '10_19YRS_CT_Male', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_10_19_YRS_CT_TOTAL]', '10_19YRS_CT_Total', 'COLUMN';

EXEC sp_rename 'malaria_data1.[_20_YRS_FEMALE_CT]', '20+YRS_CT_Female', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_20_YRS_MALE_CT]', '20+YRS_CT_Male', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_20_YRS_CT_TOTAL]', '20+YRS_CT_Total', 'COLUMN';

EXEC sp_rename 'malaria_data1.[_29DAYS_4YRS_FEMALE_CT]', '29Days_4Yrs_CT_Female', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_29_DAYS_4YRS_MALE_CT]', '29Days_4Yrs_CT_Male', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_29_DAYS_4YRS_CT_TOTAL]', '29Days_4Yrs_CT_Total', 'COLUMN';

EXEC sp_rename 'malaria_data1.[_5_9YRS_FEMALE_CT]', '5_9YRS_CT_Female', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_5_9YRS_MALE_CT]', '5_9YRS_CT_Male', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_5_9YRS_CT_TOTAL]', '5_9YRS_CT_Total', 'COLUMN';
EXEC sp_rename 'malaria_data1.[PREG_10_19YRS]', 'Preg_10_19', 'COLUMN';
EXEC sp_rename 'malaria_data1.[PREG_20_YRS]', 'Preg_20Plus', 'COLUMN';
EXEC sp_rename 'malaria_data1.[TOTAL_PREG]', 'Preg_Total', 'COLUMN';

EXEC sp_rename 'malaria_data1.[TOTAL_CASES_FEMALE]', 'TotalCases_Female', 'COLUMN';
EXEC sp_rename 'malaria_data1.[TOTAL_CASES_MALE]', 'TotalCases_Male', 'COLUMN';
EXEC sp_rename 'malaria_data1.[GRAND_TOTAL_CASES]', 'GrandTotalCases', 'COLUMN';

EXEC sp_rename 'malaria_data1.[_5YRS_FEMALES_TOTAL]', 'Under5_Female_Total', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_5YRS_MALE_TOTAL]', 'Under5_Male_Total', 'COLUMN';
EXEC sp_rename 'malaria_data1.[_5YRS_GRAND_TOTAL]', 'Under5_GrandTotal', 'COLUMN';

EXEC sp_rename 'malaria_data1.[AREA_Km2]', 'Area_km2', 'COLUMN';
EXEC sp_rename 'malaria_data1.[TOTAL_POPULATION]', 'TotalPopulation', 'COLUMN';
EXEC sp_rename 'malaria_data1.[POPULATION_DENSITY_People_per_km2]', 'PopulationDensityPerKm2', 'COLUMN';

EXEC sp_rename 'malaria_data1.[CORDINATES_LATITUDE_N]', 'Latitude', 'COLUMN';
EXEC sp_rename 'malaria_data1.[CORDINATES_LONGITUDE_E]', 'Longitude', 'COLUMN';

EXEC sp_rename 'malaria_data1.[Year]', 'Year', 'COLUMN';
EXEC sp_rename 'malaria_data1.[Incidence_Rate]', 'IncidenceRate', 'COLUMN';
EXEC sp_rename 'malaria_data1.[POPULATION_DENSITY]', 'PopulationDensity', 'COLUMN';


--Number of Rows 
SELECT COUNT(*)  From malaria_data;


--19/01/2026
--Changing Datatypes

  ALTER TABLE malaria_data1 ALTER  COLUMN Region NVARCHAR(30);
  ALTER TABLE malaria_data1  ALTER  COLUMN District NVARCHAR(30);
  ALTER TABLE malaria_data1  ALTER COLUMN "0-28Days_Female" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "0_28Days_Male" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "0_28Days_Total" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "10_19Days_Female" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "10_19Days_Male" INT;
  ALTER TABLE malaria_data1 ALTER  COLUMN "10_19Days_Total" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "20+YRS_Female" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "20+YRS_Male" INT;
  ALTER TABLE malaria_data1 ALTER  COLUMN "20+YRS_Total" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "5_9YRS_Female" INT;
  ALTER TABLE malaria_data1 ALTER  COLUMN "5_9YRS_Male" INT;
  ALTER TABLE malaria_data1 ALTER  COLUMN "5_9YRS_Total" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "29Days_4Yrs_Female" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "29Days_4Yrs_Male" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "29Days_4Yrs_Total" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "0_28Days(BSRDT)_Female" INT;
  ALTER  TABLE malaria_data1 ALTER  COLUMN "0_28Days(BSRDT)_Male" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "0_28Days(BSRDT)_Total" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "10_19YRS(BSRDT)_Female" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "10_19YRS(BSRDT)_Male" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "10_19YRS(BSRDT)_Total" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "20+YRS_(BSRDT)_Female" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "20+YRS_(BSRDT)_Male" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "20+YRS_(BSRDT)_Total" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "29Days_4Yrs(BSRDT)_Female" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "29Days_4Yrs(BSRDT)_Male" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "29Days_4Yrs(BSRDT)_Total" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "5_9YRS(BSRDT)_Female" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "5_9YRS(BSRDT)_Male" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "5_9YRS(BSRDT)_Total" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "TotalCasesConfirmed_BSRDT" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "0_28Days_CT_Female" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "0_28Days_CT_Male" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "0_28Days_CT_Total" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "10_19YRS_CT_Female" INT;
  ALTER  TABLE malaria_data1 ALTER COLUMN "10_19YRS_CT_Male" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "10_19YRS_CT_Total" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "20+YRS_CT_Female" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "20+YRS_CT_Male" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "20+YRS_CT_Total" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "29Days_4Yrs_CT_Female" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "29Days_4Yrs_CT_Male" INT;
  ALTER  TABLE malaria_data1 ALTER COLUMN "29Days_4Yrs_CT_Total" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "5_9YRS_CT_Female" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "5_9YRS_CT_Male" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "5_9YRS_CT_Total" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "Preg_10_19" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "Preg_20Plus" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "Preg_Total" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "TotalCases_Female" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "TotalCases_Male" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "GrandTotalCases" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "Under5_Female_Total" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "Under5_Male_Total" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "Under5_GrandTotal" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "Area_km2" DECIMAL(18,8);
  ALTER TABLE malaria_data1 ALTER COLUMN TotalPopulation DECIMAL(18,8);
  ALTER TABLE malaria_data1 ALTER COLUMN "PopulationDensityPerKm2" DECIMAL(18,8);
  ALTER TABLE malaria_data1 ALTER COLUMN "Latitude" DECIMAL(9,6);
  ALTER TABLE malaria_data1 ALTER COLUMN "Longitude" DECIMAL(9,6);
  ALTER TABLE malaria_data1 ALTER COLUMN "Year" INT;
  ALTER TABLE malaria_data1 ALTER COLUMN "IncidenceRate" DECIMAL(18,8);
  ALTER TABLE malaria_data1 ALTER COLUMN "PopulationDensity" DECIMAL(18,8);

  --Checking out New datatypes 
  EXEC sp_help malaria_data1;

  --Realise Duplicates in Region Column and District Column
  SELECT DISTINCT(Region) 
  FROM malaria_data
  WHERE Region IN (
		SELECT DISTINCT(District)
		FROM malaria_data
  ) AND  YEAR = '2020'
  ORDER BY Region;


    --Realise Duplicates in Region Column and District Column
  SELECT DISTINCT(TotalCasesConfirmed_BSRDT) , Region 
  FROM malaria_data
  WHERE Region IN (
		SELECT DISTINCT(District)
		FROM malaria_data
  ) AND Year = '2020'
  ;

  /** PERFOMING DATA QUALITY CHECKS ON B/S & RDT confirmed **/

  WITH Total_cases As(
  SELECT Region, SUM(TOTALCasesConfirmed_BSRDT) As TotalConfirmed_2020
  FROM malaria_data
  WHERE Region IN (
		SELECT DISTINCT District 
		FROM malaria_data  
  )
  AND YEAR = '2020'
 GROUP BY Region
  --ORDER BY Region
  )
  --SELECT * FROM Total_caseS;
  SELECT SUM(TotalConfirmed_2020) As Total_cases
  FROM Total_cases;




  SELECT Region, SUM(TotalCasesConfirmed_BSRDT) AS TotalConfirmed_2020
FROM malaria_data
WHERE Region IN (
    SELECT DISTINCT District
    FROM malaria_data
)
AND Year = 2020
GROUP BY Region
ORDER BY Region;

SELECT Region, SUM(TotalCasesConfirmed_BSRDT) AS TotalConfirmed_2020
FROM malaria_data
WHERE Region IN (
    SELECT DISTINCT District
    FROM malaria_data
)
AND Year = 2020
--AND Region <> District
GROUP BY Region
ORDER BY Region;

WITH Total_Cases2_cte AS(
SELECT Region, TotalCasesConfirmed_BSRDT
FROM malaria_data
WHERE Region = District
AND Year = 2020
--ORDER BY Region
)
--SELECT * FROM Total_Cases2_cte;
SELECT SUM(TotalCasesConfirmed_BSRDT) As Total_Cases1
FROM Total_Cases2_cte;

WITH Total_cte AS (
SELECT Region, District, [10_19Days_Total] FROM malaria_data
WHERE Region = 'Lango' AND YEAR = '2020'
)
--SELECT * FROM Total_cte;

SELECT SUM([10_19Days_Total]) As total_cases
FROM Total_cte;


--Total population By District 
SELECT 
    Year,
    SUM(TotalPopulation) AS total_population
FROM malaria_data
WHERE Year = 2021
  AND LOWER(District) LIKE '% district'
GROUP BY Year;


--Total Population by region


    WITH valid_districts AS (
    SELECT *
    FROM malaria_data
    WHERE LOWER(District) LIKE '%district%'
)
SELECT 
    Year,
    SUM(TotalPopulation) AS total_population
FROM valid_districts
WHERE Year = 2020
AND District IN ('Buhweju District','Bushenyi District', 'Ibanda District', 'Isingiro District','Kazo District','Kiruhura District', 
'Mbarara District', 'Mitooma District', 'Ntugamo District', 'Rubirirzi District', 'Rwampara District',
'Sheema District', 'Mbarara City')
GROUP BY Year;


--Region Level
SELECT
Year,
SUM(TotalPopulation) AS Total_Population
FROM malaria_data
WHERE Region = District AND  Year = 2020
AND Region = 'Ankole'

GROUP BY  Year;



    WITH valid_districts AS (
    SELECT *
    FROM malaria_data
   WHERE LOWER(District) LIKE '%district%'
)

SELECT 
    Year,
    SUM(TotalPopulation) AS total_population
FROM valid_districts
WHERE Year = 2020
AND District IN ( 'Mbarara district')
GROUP BY Year;

--Find Out How many Districts do we have
SELECT COUNT(*) As TotalDistricts 
 FRom malaria_data 
 WHERE LOWER(District) LIKE '%district%' AND Year = 2020;


--Find Out How many Regions we have
 SELECT COUNT(*) As TotalRegions 
 FRom malaria_data 
 WHERE District = Region AND Year = 2020;



 ---19/01/2026
 SELECT * FROM malaria_data1;