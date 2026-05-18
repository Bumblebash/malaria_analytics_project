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
       INNER JOIN [MalariaWareHouse_DB].dbo.DimDistrict d
       ON p.District  = d.DistrictName ;


       SELECT * FROM DimPopulation;
