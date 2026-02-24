USE Malaria_DB;



----Enriching the Popualation columns for North Central and South Central
UPDATE Stg_Malaria 
SET Population = '1428775'
WHERE Year = '2024' AND Region = 'North Central' AND Region = District;


======================================================================================================-
--INGEST DateDimension data into Dimdate
INSERT INTO DimDate
SELECT DISTINCT
       Year*10000 + Month*100 + 1 AS DateKey,
       DATEFROMPARTS(Year,Month,1),
       Year,
       DATEPART(QUARTER, DATEFROMPARTS(Year, Month,1)),
       Month,
       DATENAME(MONTH, DATEFROMPARTS(Year, Month,1)),
       CONCAT(Year, '_', RIGHT('0' +CAST(Month AS VARCHAR), 2))
FROM Stg_Malaria;

---Checkout the data ingested
SELECT *FROM DimDate;

=======================================================================================================================================
--INGEST INTO Region Dimension
INSERT INTO DimRegion 
SELECT DISTINCT Region
FROM stg_Malaria
WHERE Region NOT IN (SELECT Region FROM DimRegion);
SELECT *FROM DimRegion;


=====================================================================================================================================================

---LOAD IN DISTRICT
SELECT * FROM DimDistrict;

==================================================================================================================================================
--LOAD INTO AgeGroup
SELECT * FROM DimAgeGroup;

INSERT INTO DimAgeGroup (AgeGroup, MinAge, MaxAge)
SELECT DISTINCT
    AgeGroup,
    CASE
        WHEN AgeGroup = '0-28Dys' THEN 0
        WHEN AgeGroup = '1-4yrs' THEN 1
        WHEN AgeGroup = '5-9yrs' THEN 5
        WHEN AgeGroup = '10-19yrs' THEN 10
        WHEN AgeGroup = '20+' THEN 20
    END AS MinAge,
    CASE
        WHEN AgeGroup = '0-28Dys' THEN 0
        WHEN AgeGroup = '1-4yrs' THEN 4
        WHEN AgeGroup = '5-9yrs' THEN 9
        WHEN AgeGroup = '10-19yrs' THEN 19
        WHEN AgeGroup = '20+' THEN NULL
    END AS MaxAge
FROM Stg_Malaria
WHERE AgeGroup IS NOT NULL;

SELECT * FROM DimAgeGroup;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
--24/02/2026
--LOAD INTO DIMGENDER

INSERT INTO DimGender (Gender)
SELECT DISTINCT Gender
FROM Stg_Malaria ;
 ---Confirm Data in DimGender
 SELECT * FROM DimGender;

 ----------------------------------------------------------------------------------------------------------------------------------------------------
 -----CHECKING OUT DATA INSIDE Dimensions and Facts
SELECT * FROM DimDistrict
SELECT * FROM DimDate
SELECT * FROM DimGender
SELECT * FROM DimAgeGroup
SELECT * FROM DimRegion
SELECT * FROM FactMalaria;

-------------------------------------------------------------------------------------------------------------------------------------------

-----LOADING DATA INTO FACT TABLE
INSERT INTO FactMalaria
(
DateKey,
DistrictKey,
RegionKey,
AgeKey,
GenderKey,
ConfirmedCases,
TreatedCases,
Population
)
SELECT
     d.DateKey,
     dist.DistrictKey,
     reg.RegionKey,
     age.AgeKey,
     gen.GenderKey,


     SUM(m.ConfirmedCases),
     SUM(m.TreatedCases),
     m.Population
FROM Stg_Malaria m

JOIN DimDate d ON m.Year = d.Year
JOIN DimDistrict dist ON m.District = dist.DistrictName
JOIN DimRegion reg ON dist.RegionKey = reg.RegionKey
JOIN DimAgeGroup age ON m.AgeGroup = age.AgeGroup
JOIN DimGender gen ON m.Gender = gen.Gender


GROUP BY 
        d.DateKey,
        dist.DistrictKey,
        reg.RegionKey,
        age.AgeKey,
        gen.GenderKey,
        m.Population;
     

SELECT * FROM  FactMalaria;

 
