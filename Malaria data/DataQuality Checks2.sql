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

 --------------------------------------------------------------------------------------------------------------------------------------------------------
 --------------------------------------------------------------------------------------------------------------------------------------------------------

 --U5 Cases per Year Strictly

WITH Total_cases_cte AS(
SELECT 

       Year,
      SUM( TOTAlCasesConfirmed_BSRDT ) As Total_Cases,
       SUM(
       [0_28Days(BSRDT)_Total]+
       [29Days_4Yrs(BSRDT)_Total]
       ) AS U5TotalCases
    FROM malaria_data1 
       WHERE Region = District AND Region <> '0' 
    GROUP BY  Year
    )
     SELECT 
     Year, 
     Total_Cases, 
     U5TotalCases,
     CAST(ROUND((CAST((U5TotalCases) AS DECIMAL(18,2)) / CAST((Total_Cases) AS DECIMAL (18,2) )) * 100,2) AS DECIMAL(18,2)) AS U5YrBurden
     FROM Total_cases_cte
      ORDER BY Year ASC;


----Cases Treated Vs Cases Confirmed 

WITH treated_cases_cte AS (
SELECT 
       Year,
       SUM(TOTAlCasesConfirmed_BSRDT) As Total_Cases,
       SUM([0_28Days_CT_Total] + 
       [29Days_4Yrs_CT_Total] + 
       [5_9YRS_CT_Total] + 
       [10_19YRS_CT_Total] + 
       [20+YRS_CT_Total]) As total_Cases_Treated 
    FROM malaria_data1 
       WHERE Region = District AND Region <> '0'
    GROUP BY  Year
   
   )
       SELECT 
       Year, 
       Total_Cases, 
       total_Cases_Treated, 
       CAST(ROUND( (CAST((total_Cases_Treated) AS DECIMAL(18,2))/ CAST((Total_Cases) AS Decimal(18,2)) ) * 100, 2) AS DECIMAL(18,2)) As Percentage_Treatment_Coverage 
                FROM treated_cases_cte
                 ORDER BY  Year;




/**Extracting Cases Treated Vs Cases Confirmed**/

WITH treated_cases_cte AS (
SELECT 
       Region, 
       Year,
       TOTAlCasesConfirmed_BSRDT As Total_Cases,
       SUM([0_28Days_CT_Total] + 
       [29Days_4Yrs_CT_Total] + 
       [5_9YRS_CT_Total] + 
       [10_19YRS_CT_Total] + 
       [20+YRS_CT_Total]) As total_Cases_Treated 
    FROM malaria_data1 
       WHERE Region = District AND Region <> '0'
    GROUP BY Region,TOTAlCasesConfirmed_BSRDT, Year
   
   )
       SELECT Region, 
       Year, 
       Total_Cases, 
       total_Cases_Treated, 
       CAST(ROUND( (CAST((total_Cases_Treated) AS DECIMAL(18,2))/ CAST((Total_Cases) AS Decimal(18,2)) ) * 100, 2) AS DECIMAL(18,2)) As Percentage_Treatment_Coverage 
                FROM treated_cases_cte
                 ORDER BY region , Year;



--5-9YRS AGE CATEGORY 
/**Extracting Percentage Burden in 5-9yRs Age Group  Per Year Per Region (5-9YRS)**/

--Percentage by Region by Age_group(5_9yrs) by Year 
WITH total_Cases_cte AS(
        SELECT 
        Region, 
        Year, 
        TOTAlCasesConfirmed_BSRDT As total_cases, SUM([5_9YRS(BSRDT)_Total]) AS [total_cases_btn(5_9)] 
    FROM malaria_data1
        WHERE Region = District AND Region <> '0'
        GROUP BY Region , Year, TOTAlCasesConfirmed_BSRDT
)
    SELECT 
         Region,  
         Year, 
         total_cases, [total_cases_btn(5_9)] , 
         CAST( ROUND((CAST([total_cases_btn(5_9)] AS DECIMAL(18,2)) / CAST( total_cases AS DECIMAL(18,2)) * 100),2) AS DECIMAL(18,2)) AS [5_9_yrs_by_percentage]
    FROM total_Cases_cte ;



----Percentage  By Year(Strictly) per 5_9_Yrs_By_Percentage
    WITH total_Cases_cte AS(
        SELECT 
        Year, 
        SUM(TOTAlCasesConfirmed_BSRDT) As total_cases, SUM([5_9YRS(BSRDT)_Total]) AS [total_cases_btn(5_9)] 
    FROM malaria_data1
        WHERE Region = District AND Region <> '0'
        GROUP BY Year
)
    SELECT 
         
         Year, 
         total_cases, [total_cases_btn(5_9)] , 
         CAST( ROUND((CAST([total_cases_btn(5_9)] AS DECIMAL(18,2)) / CAST( total_cases AS DECIMAL(18,2)) * 100),2) AS DECIMAL(18,2)) AS [5_9_yrs_by_percentage]
    FROM total_Cases_cte ;





    --11/01/2025
-------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
   --ADULTS (10-20+YRS)
/**Extracting Percentage Burden in Adults Per Year Per Region*/
--(10-19yrs) & (20+Yrs) Age Bracket
WITH adult_cte AS(
SELECT 
Region , 
    Year,
     TOTAlCasesConfirmed_BSRDT AS total_Cases, 
    SUM([10_19YRS(BSRDT)_Total] + [20+YRS_(BSRDT)_Total]) AS Total_Adult_Cases
FROM malaria_data1
    WHERE Region = District AND Region <> '0'
    GROUP BY Region, Year, TOTAlCasesConfirmed_BSRDT
    )

    SELECT Region,
           Year,
           total_cases,
           Total_Adult_Cases,
           CAST(ROUND(((CAST((Total_Adult_Cases) AS DECIMAL(18,2)) / CAST((total_cases) AS DECIMAl(18,2))) * 100),2) AS DECIMAL(18,2)) AS Adult_percentage
    FROM adult_cte ;


     --Strictly Percentage by Age Group (ADULT) Per Year 

    WITH adult_cte AS(
SELECT 
    Year,
     SUM(TOTAlCasesConfirmed_BSRDT) AS total_Cases, 
    SUM([10_19YRS(BSRDT)_Total] + [20+YRS_(BSRDT)_Total]) AS Total_Adult_Cases
FROM malaria_data
    WHERE Region = District AND Region <> '0'
    GROUP BY  Year
    )

    SELECT
           Year,
           total_cases,
           Total_Adult_Cases,
           CAST(ROUND(((CAST((Total_Adult_Cases) AS DECIMAL(18,2)) / CAST((total_cases) AS DECIMAl(18,2))) * 100),2) AS DECIMAL(18,2)) AS Adult_percentage
    FROM adult_cte ;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------           
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




---PERCENTAGE BY GENDER
----FEMALE & MALE

    WITH total_Cases_cte AS(
        SELECT 
        Year,  
        SUM(TOTAlCasesConfirmed_BSRDT) As total_cases,
        SUM([0_28Days(BSRDT)_Female] +
             [29Days_4Yrs(BSRDT)_Female]+
             [5_9YRS(BSRDT)_Female]+
             [10_19YRS(BSRDT)_Female]+
             [20+YRS_(BSRDT)_Female]) AS Total_female_Cases,
        SUM([0_28Days(BSRDT)_Male] +
             [29Days_4Yrs(BSRDT)_Male]+
             [5_9YRS(BSRDT)_Male]+
             [10_19YRS(BSRDT)_Male]+
             [20+YRS_(BSRDT)_Male]) AS Total_Male_Cases
    FROM malaria_data1
        WHERE Region = District AND Region <> '0'
        GROUP BY Year
)
    SELECT 
         
         Year, 
         total_cases, Total_female_Cases, Total_Male_Cases,
         CAST( ROUND((CAST([Total_female_Cases] AS DECIMAL(18,2)) / CAST( total_cases AS DECIMAL(18,2)) * 100),2) AS DECIMAL(18,2)) AS Percentage_Total_Cases_Female,
         CAST( ROUND((CAST([Total_Male_Cases] AS DECIMAL(18,2)) / CAST( total_cases AS DECIMAL(18,2)) * 100),2) AS DECIMAL(18,2)) AS Percentage_Total_Cases_Male
    FROM total_Cases_cte ;

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



        /** METHOD II **/
WITH previous_year_cte AS(
  SELECT Region, Year, TOTAlCasesConfirmed_BSRDT As Current_Total_Cases, 
       LAG(TOTAlCasesConfirmed_BSRDT) OVER(PARTITION BY Region ORDER BY Year) As Previous_Total_Cases
       FROM malaria_data1
       WHERE Region = District AND Region <> '0' AND Region IS NOT NULL
       )
SELECT Region, Year, Current_Total_Cases, Previous_Total_Cases,
       CASE WHEN Previous_Total_Cases IS NULL THEN NULL --For the First Year
       WHEN Previous_Total_Cases = 0 THEN NULL  --Avoids Division By Zero
       ELSE 
 CAST(ROUND(
   (CAST(Current_Total_Cases AS DECIMAL(18,2)) --- Assign Every Column with Cast AS DECIMAL(18,2)
    - CAST(Previous_Total_Cases AS DECIMAL(18,2)))
   / CAST(Previous_Total_Cases AS DECIMAL(18,2)) * 100, 2) 
   AS DECIMAL(18,2) )   ---Logic in division 
       END AS Y_0_Y_Change
       FROM previous_year_cte;


--Confirming Incidence Rates Per Region
 SELECT Region, SUM(IncidenceRate) As Total_Incidence_Rates, Year
    FROM malaria_data1
    GROUP BY Region, Year;

