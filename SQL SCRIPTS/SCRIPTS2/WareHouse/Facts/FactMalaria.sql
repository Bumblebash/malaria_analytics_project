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