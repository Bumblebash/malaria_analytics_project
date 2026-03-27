USE Malaria_DB;

---DATA INGESTION INTO STAGING LAYER

DECLARE @cols NVARCHAR(MAX);

-- Build dynamic column list from source table
SELECT @cols = STRING_AGG(CAST(QUOTENAME(COLUMN_NAME) AS NVARCHAR(MAX)), ',')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Malaria2024'
  AND (
       COLUMN_NAME LIKE '105-EP01c%'   -- Confirmed Cases
       OR COLUMN_NAME LIKE '105-EP01d%' -- Treated Cases
       OR COLUMN_NAME LIKE '105-MC04%'  -- Malaria in pregnancy
      );

DECLARE @sql NVARCHAR(MAX);

SET @sql = '
WITH Unpivoted AS (
    SELECT
        orgunitlevel2 AS Region,
        organisationunitname AS District,
        Population,
        ColName,
        Value
    FROM Malaria2024
    UNPIVOT (
        Value FOR ColName IN (' + @cols + ')
    ) u
),
Parsed AS (
    SELECT 
        Region, 
        District,
        Population,
        CAST(RIGHT(ColName,4) AS INT) AS Year,

        CASE
            WHEN ColName LIKE ''%January%'' THEN 1
            WHEN ColName LIKE ''%February%'' THEN 2
            WHEN ColName LIKE ''%March%'' THEN 3
            WHEN ColName LIKE ''%April%'' THEN 4
            WHEN ColName LIKE ''%May%'' THEN 5
            WHEN ColName LIKE ''%June%'' THEN 6
            WHEN ColName LIKE ''%July%'' THEN 7
            WHEN ColName LIKE ''%August%'' THEN 8
            WHEN ColName LIKE ''%September%'' THEN 9
            WHEN ColName LIKE ''%October%'' THEN 10
            WHEN ColName LIKE ''%November%'' THEN 11
            WHEN ColName LIKE ''%December%'' THEN 12
        END AS Month,

        CASE 
            WHEN ColName LIKE ''105-EP01c%'' THEN ''ConfirmedCases''
            WHEN ColName LIKE ''105-EP01d%'' THEN ''TreatedCases''
            WHEN ColName LIKE ''105-MC04%''  THEN ''PregnancyCases''
        END AS CaseType,

        CASE
            WHEN ColName LIKE ''%0-28Dys%'' THEN ''0-28Dys''
            WHEN ColName LIKE ''%29Dys-4Yrs%'' THEN ''29Days-4yrs''
            WHEN ColName LIKE ''%5-9Yrs%'' THEN ''5-9yrs''
            WHEN ColName LIKE ''%10-19Yrs%'' THEN ''10-19yrs''
            WHEN ColName LIKE ''%20+Yrs%'' THEN ''20+''
        END AS AgeGroup,

        CASE 
            WHEN ColName LIKE ''%Female%'' THEN ''Female''
            WHEN ColName LIKE ''%Male%'' THEN ''Male''
        END AS Gender,

        Value
    FROM Unpivoted
)
INSERT INTO Stg_Malaria(
    Region,
    District,
    Year,
    Month,
    AgeGroup,
    Gender,
    ConfirmedCases,
    TreatedCases,
    PregnancyCases,
    Population
)
SELECT 
     Region,
     District,
     Year,
     Month,
     AgeGroup,
     Gender,
     SUM(CASE WHEN CaseType = ''ConfirmedCases'' THEN Value ELSE 0 END) AS ConfirmedCases,
     SUM(CASE WHEN CaseType = ''TreatedCases'' THEN Value ELSE 0 END) AS TreatedCases,
     SUM(CASE WHEN CaseType = ''PregnancyCases'' THEN Value ELSE 0 END) AS PregnancyCases,
     Population
FROM Parsed
GROUP BY 
       Region,
       District,
       Year, 
       Month,
       AgeGroup,
       Gender,
       Population;
'

EXEC sp_executesql @sql;


--Confirming Number of Columns in Staging Malaria2023 CSV
SELECT 
      COUNT(*) AS NumberOfColumns 
FROM 
    INFORMATION_SCHEMA.COLUMNS 
WHERE 
     TABLE_NAME = 'Malaria2023'
     AND TABLE_SCHEMA = 'dbo';


     TRUNCATE TABLE Stg_Malaria;

     SELECT  * FROM Stg_Malaria;
     

     SELECT COUNT(*) FROM Stg_Malaria;
     SELECT COUNT(*) FROM FactMalaria;




     SELECT COUNT(*) AS NumberColumns
     FROM 
      INFORMATION_SCHEMA.COLUMNS 
      WHERE 
      TABLE_NAME = 'Malaria2024'
      AND  TABLE_SCHEMA = 'dbo';

      EXEC sp_help Stg_Malaria;


      TRUNCATE TABLE Stg_Malaria;

DROP TABLE Malaria2020
DROP TABLE Malaria2021
DROP TABLE Malaria2022
DROP TABLE Malaria2023
DROP TABLE Malaria2024


SELECT * FROM Stg_Malaria;



ALTER TABLE Stg_Malaria ADD  PregnancyCases INT;









SELECT * FROM Malaria2024;
DROP TABLE Malaria2020;



      CREATE VIEW vw_MalariaRaw AS

SELECT * FROM Malaria2020
UNION ALL
SELECT * FROM Malaria2021
UNION ALL
SELECT * FROM Malaria2022
UNION ALL
SELECT * FROM Malaria2023
UNION ALL
SELECT * FROM Malaria2024;







SELECT COUNT(*) AS NumberofColumns
FROM
  INFORMATION_SCHEMA.COLUMNS
  WHERE 
       TABLE_NAME = 'Malaria2020'
       AND TABLE_SCHEMA = 'dbo';

       SELECT COUNT(*) AS NumberofColumns
FROM
  INFORMATION_SCHEMA.COLUMNS
  WHERE 
       TABLE_NAME = 'Malaria2021'
       AND TABLE_SCHEMA = 'dbo';


       SELECT COUNT(*) AS NumberofColumns
FROM
  INFORMATION_SCHEMA.COLUMNS
  WHERE 
       TABLE_NAME = 'Malaria2022'
       AND TABLE_SCHEMA = 'dbo';


       SELECT COUNT(*) AS NumberofColumns
FROM
  INFORMATION_SCHEMA.COLUMNS
  WHERE 
       TABLE_NAME = 'Malaria2023'
       AND TABLE_SCHEMA = 'dbo';


       SELECT COUNT(*) AS NumberofColumns
FROM
  INFORMATION_SCHEMA.COLUMNS
  WHERE 
       TABLE_NAME = 'Malaria2024'
       AND TABLE_SCHEMA = 'dbo';
