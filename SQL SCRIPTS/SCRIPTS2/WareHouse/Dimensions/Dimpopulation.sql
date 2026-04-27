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