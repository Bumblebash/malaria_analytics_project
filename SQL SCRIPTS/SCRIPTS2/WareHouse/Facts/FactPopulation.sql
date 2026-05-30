USE MalariaWareHouse_DB;


CREATE TABLE Fact_Population(
		PopulationKey INT IDENTITY(1,1) PRIMARY KEY,
		DistrictKey INT NOT NULL,
		DateKey INT NOT NULL,
		Estimated_Population INT NOT NULL,
CONSTRAINT FK_Popn_District FOREIGN KEY (DistrictKey)
REFERENCES DimDistrict(DistrictKey),

CONSTRAINT FK_Popn_Date FOREIGN KEY(DateKey)
REFERENCES DimDate(DateKey)

);



---INSERT DATA INTO THE FactPopulation_Table
INSERT INTO Fact_Population( DistrictKey, DateKey, Estimated_Population)
SELECT 
		dist.DistrictKey,
		d.DateKey,
		e.Estimated_Population
		FROM Dimpopulation e 
 JOIN DimDistrict dist  ON e.DistrictKey = dist.DistrictKey
 JOIN DimDate d ON e.Year = d.Year
 WHERE d.Month = 1
;

 SELECT * FROM Fact_Population;

 TRUNCATE TABLE Fact_population;


SELECT * FROM DimDate;