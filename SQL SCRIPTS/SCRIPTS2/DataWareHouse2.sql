USE Malaria_DB1;
--DATA MIGRATION
SELECT * INTO Malaria_DB1.dbo.Malaria2024
FROM Malaria_DB.dbo.Malaria2024;
SELECT * FROM Malaria2021;

---Creation Of Permanent Staging Table 
CREATE TABLE Stg_Malaria_Permanent (

	---Business Grains
	Region VARCHAR(100) NOT NULL,
	District VARCHAR(100) NOT NULL,
	Year INT NOT NULL, 
	Month INT  NOT NULL,
	AgeGroup VARCHAR(50) NOT NULL,
	Gender VARCHAR(10) NOT NULL,

	---Fact/Measures
	ConfirmedCases INT, 
	TreatedCases INT,
	PregnancyCases INT,
	Population INT,
	
	--Audit/Governance  Columns
	IngestionTimestamp DATETIME DEFAULT GETDATE(),

	--Primary Key to prevent Ingestion of Duplicates
	PRIMARY KEY (Region, District, Year, Month, AgeGroup, Gender)
);
GO

-- Index for Query Optimization(Makes Queries Faster when Filtering)
CREATE INDEX IX_Stg_Grains ON Stg_Malaria_Permanent(Region, District, Year, Month);
GO 


DROP TABLE Stg_Malaria_Permanent;
SELECT * FROM Stg_Malaria_Permanent;
