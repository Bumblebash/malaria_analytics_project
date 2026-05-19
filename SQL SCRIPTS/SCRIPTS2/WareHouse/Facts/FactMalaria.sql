USE MalariaWareHouse_DB;


--CREATING FACT TABLE
CREATE TABLE Fact_Malaria(
       FactID  BIGINT IDENTITY(1,1) PRIMARY KEY,
       RegionKey INT NOT NULL,
       DistrictKey INT NOT NULL,
       PopulationKey INT NOT NULL,
       DateKey INT NOT NULL,
       Genderkey INT NOT NULL,
       AgeKey INT NOT NULL,

       --Measures
       ConfirmedCases INT NOT NULL,
       TreatedCases INT NOT NULL,
       TotalCases INT NOT NULL,

       LoadDate DATETIME DEFAULT GETDATE(),

       --Constraints
       --DateConstraint--
       CONSTRAINT FK_Fact_Date
              FOREIGN KEY (DateKey) 
              REFERENCES DimDate(DateKey),

        ---RegionConstraint---
        CONSTRAINT FK_Fact_Region
                FOREIGN KEY (RegionKey)
                REFERENCES DimRegion(RegionKey),
        
        ---DistrictConstraint--
        CONSTRAINT FK_Fact_District
                   FOREIGN KEY (DistrictKey)
                   REFERENCES DimDistrict(Districtkey),

        ---PopulationConstraint--
        CONSTRAINT FK_Fact_Population
                   FOREIGN KEY (PopulationKey)
                   REFERENCES DimPopulation(PopulationKey),

        ----Gender Constraint--
        CONSTRAINT FK_Fact_Gender
                   FOREIGN KEY (GenderKey)
                   REFERENCES DimGender(GenderKey),

        ---AgeGroup Constraint---
        CONSTRAINT FK_Fact_AgeGroup
                   FOREIGN  KEY (AgeKey)
                   REFERENCES DimAgeGroup(AgeKey)                

);
EXEC sp_help Fact_Malaria;

ALTER TABLE FactMalaria ADD COLUMN TotalCases

ALTER TABLE Fact_Malaria ADD  PopulationKey INT ;
ALTER TABLE Fact_Malaria ALTER COLUMN  PopulationKey INT NOT NULL;
SELECT * FROM Fact_Malaria;

EXEC sp_pkeys Fact_Malaria;
ALTER TABLE Fact_Malaria
DROP CONSTRAINT FK_Fact_Population;

ALTER TABLE Fact_Malaria DROP COLUMN PopulationKey;

ALTER 

ALTER TABLE Fact_Malaria 
ADD CONSTRAINT FK_Fact_Population 
FOREIGN KEY (PopulationKey)
REFERENCES DimPopulation(PopulationKey);

SELECT * FROM Fact_Malaria;



/**INSERTION OF DATA INTO THE FACT TABLE **/

INSERT INTO Fact_Malaria(RegionKey, DistrictKey,DateKey, Genderkey, AgeKey, ConfirmedCases,TreatedCases, TotalCases)
SELECT 
     d.DateKey,
     dist.DistrictKey,
     dist.RegionKey,
     age.AgeKey,
     gen.GenderKey,
     m.ConfirmedCases,
     m.TreatedCasesRecorded,
     m.Population
FROM Stg_Malaria m

JOIN DimDate d ON m.Year = d.Year AND d.Month = m.Month
JOIN DimDistrict dist ON m.District = dist.DistrictName
JOIN DimAgeGroup age ON m.AgeGroup = age.AgeGroup
JOIN DimGender gen ON m.Gender = gen.Gender
;

INSERT INTO Fact_Malaria(RegionKey,DistrictKey, DateKey, GenderKey, AgeKey, ConfirmedCases, TreatedCases, TotalCases)
SELECT
       dist.RegionKey,
       dist. DistrictKey,
       --p.PopulationKey,
       d.DateKey,
       gen.GenderKey,
       age.AgeKey,
       m.ConfirmedCases,
       m.TreatedCases,
       m.TotalCasesRecorded As TotalCases
FROM [MalariaLanding_DB].dbo.Stg_Malaria_Permanent m
JOIN DimDate d ON m.Year = d.Year AND d.Month = m.Month
--JOIN Dimpopulation p ON m.District = p.DistrictName
JOIN DimDistrict dist ON m.District = dist.DistrictName
JOIN DimAgeGroup age ON m.AgeGroup = age.AgeGroup
JOIN DimGender gen ON m.Gender = gen.Gender
;

TRUNCATE TABLE Fact_Malaria;
SELECT * FROM Fact_Malaria;
USE MalariaLanding_DB;
SELECT * FROM Stg_Malaria_Permanent;