USE MalariaWareHouse_DB;

--CREATING AgeGroup Dimension
CREATE TABLE DimAgeGroup(
    AgeKey INT IDENTITY(1,1) PRIMARY KEY,
    AgeGroup NVARCHAR(50) NOT NULL UNIQUE,
    MinAge NVARCHAR NOT NULL,
    MaxAge NVARCHAR NOT NULL
);
GO

ALTER TABLE DimAgeGroup ALTER  COLUMN MaxAge INT NULL
ALTER  TABLE DimAgeGroup ALTER COLUMN MinAge INT NULL;


SELECT * FROM DimAgeGroup;


/**Insert DimAgeGroup Data**/

INSERT INTO DimAgeGroup (AgeGroup, MinAge, MaxAge)
SELECT DISTINCT
    AgeGroup,
    CASE
        WHEN AgeGroup = '0-28Dys' THEN 0
        WHEN AgeGroup = '29Days-4yrs' THEN 1
        WHEN AgeGroup = '5-9yrs' THEN 5
        WHEN AgeGroup = '10-19yrs' THEN 10
        WHEN AgeGroup = '20+' THEN 20
    END AS MinAge,
    CASE
        WHEN AgeGroup = '0-28Dys' THEN 0
        WHEN AgeGroup = '29Days-4yrs' THEN 4
        WHEN AgeGroup = '5-9yrs' THEN 9
        WHEN AgeGroup = '10-19yrs' THEN 19
        WHEN AgeGroup = '20+' THEN NULL
    END AS MaxAge
FROM [MalariaLanding_DB].dbo.Stg_Malaria_Permanent
WHERE AgeGroup IS NOT NULL;

USE Malaria_DB;
SELECT * FROM  DimAgeGroup;








SELECT * FROM DimDistrict
SELECT * FROM DimDate
SELECT * FROM DimGender
SELECT * FROM DimAgeGroup
SELECT * FROM DimRegion
SELECT * FROM FactMalaria;
SELECT * FROM DimPopulation;


SELECT * FROM DimDistrict WHERE DistrictName  LIKE '%District%';