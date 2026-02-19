USE Malaria_DB;

DECLARE @cols NVARCHAR(MAX);

-- Build dynamic column list
SELECT @cols = STRING_AGG(CAST(QUOTENAME(COLUMN_NAME) AS NVARCHAR(MAX)), ',')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Malaria2023'
  AND (
       COLUMN_NAME LIKE '105-EP01c%'  -- Confirmed Cases
       OR COLUMN_NAME LIKE '105-EP01d%'  -- Treated Cases
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
    FROM Malaria2023
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
INSERT INTO Stg_Malaria (
    Region,
    District,
    Year,
    Month,
    AgeGroup,
    Gender,
    ConfirmedCases,
    TreatedCases,
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
';

EXEC sp_executesql @sql;

SELECT * from Stg_Malaria;
SELECT * FROM Stg_Malaria 
WHERE Region = District;

SELECT DISTINCT(Year) FROM Stg_Malaria;

DROP TABLE Malaria2023;


SELECT * FROM Malaria2023;


SELECT [105-EP01c. Malaria Confirmed (B/s and RDT Positive) 10-19Yrs, Female August 2021] FROM Malaria2021;