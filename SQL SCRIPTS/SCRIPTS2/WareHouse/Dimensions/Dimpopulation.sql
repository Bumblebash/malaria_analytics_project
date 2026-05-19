USE MalariaWareHouse_DB;

CREATE TABLE Dimpopulation(
        PopulationKey INT IDENTITY(1,1) PRIMARY KEY,
        RegionKey INT NOT NULL,
        DistrictKey INT NOT NULL,
        population_2020 INT NULL,
        population_2021 INT NULL,
        population_2022 INT NULL,
        population_2023 INT NULL,
        ppulation_2024 INT NULL,

--Constraint

 CONSTRAINT FK_Population_Region
          FOREIGN KEY(RegionKey)
          REFERENCES DimRegion(RegionKey),

CONSTRAINT FK_Population_District
           FOREIGN KEY(DistrictKey)
           REFERENCES DimDistrict(DistrictKey)

);
DROP TABLE Dimpopulation;

EXEC sp_help Dimpopulation;

SELECT * FROM DimPopulation;

ALTER TABLE Dimpopulation DROP COLUMN DistrictName;
ALTER TABLE DimPopulation ADD  Region NVARCHAR;
ALTER TABLE DimPopulation ADD DistrictName VARCHAR(30) NOT NULL;
ALTER TABLE DimPopulation DROP COLUMN Region;
ALTER TABLE DimPopulation ALTER COLUMN Region NVARCHAR(120) NOT NULL;
EXEC sp_rename 'DimPopulation.ppulation_2024', 'population_2024', 'COLUMN';
SELECT *  FROM DimPopulation;

/**Ingestion ofPopulation Data into DimPopulation**/
INSERT INTO DimPopulation( population_2020, population_2021, population_2022, population_2023, population_2024, DistrictName)
SELECT 
       population_2020 p,
       population_2021 p,
       population_2022 p,
       population_2023 p,
       population_2024 p,
       DistrictName d
       FROM [MalariaLanding_DB].dbo.Stg_Population_Permanent p
        JOIN [MalariaWareHouse_DB].dbo.DimDistrict d
       ON p.District  = d.DistrictName ;


       SELECT * FROM DimPopulation;

       TRUNCATE TABLE Dimpopulation;

       
       SELECT DISTINCT p.District AS MissingDistrictFromStaging
FROM [MalariaLanding_DB].dbo.Stg_Population_Permanent p
LEFT JOIN [MalariaWareHouse_DB].dbo.DimDistrict d ON p.District = d.DistrictName
WHERE d.DistrictName IS NULL;


DECLARE @cols NVARCHAR(MAX);

SELECT @cols = STRING_AGG(CAST(QUOTENAME(COLUMN_NAME) AS NVARCHAR(MAX)), ',')

FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME ='DimPopulation'
AND (
 COLUMN_NAME LIKE '%2020%'
 OR COLUMN_NAME LIKE '%2021%'
 OR COLUMN_NAME LIKE '%2022%'
 OR COLUMN_NAME LIKE '%2023%'
 OR COLUMN_NAME  LIKE '%2024%'
);
DECLARE @sql NVARCHAR(MAX);
SET @sql= '
WITH UNPIVOTED AS (
SELECT 
PopulationKey,
DistrictName,
ColName,
Value
FROM DimPopulation
UNPIVOT(
    Value FOR ColName IN ('+ @cols +')
) u 
),
PARSED AS (
    SELECT 
         PopulationKey,
         DistrictName,
         CAST(RIGHT(ColName,4) AS INT) AS Year,
         Value
    FROM Unpivoted
)
SELECT * FROM PARSED;

'

EXEC sp_executesql @sql;






















USE MalariaLanding_DB;
SELECT * FROM [MalariaLanding_DB].dbo.Stg_Malaria_Permanent;