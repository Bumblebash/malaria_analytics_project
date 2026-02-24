USE Malaria_DB;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
--DATE DIMENSION (DateDim)
CREATE TABLE DimDate(
	DateKey INT PRIMARY KEY,
	FullDate DATE NOT NULL,
	Year  INT NOT NULL,
	Quarter INT NOT NULL,
	Month INT NOT NULL,
	MonthName VARCHAR(15),
	YearMonth CHAR(7)

);

--Confirming datatypes for Date Dimensional table.
Exec sp_help DimDate;
------------------------------------------------------------------------------------------------------------------------------------------------------------------

--REGION DIMENSIONAL TABLE(DimRegion)
CREATE TABLE DimRegion (
   RegionKey INT IDENTITY(1,1) PRIMARY KEY,
   Region VARCHAR(100) NOT NULL UNIQUE
);
--NOTE : Unique Prevents duplicates like "Central" Vs "central"

--Confirming datatypes for Region Dimensional Table
Exec sp_help DimRegion;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------

---DISTRICT DIMESNSION(DimDistrict)

CREATE TABLE DimDistrict(
    DistrictKey INT IDENTITY(1,1) PRIMARY KEY,
	DistrictName VARCHAR(120) NOT NULL,
	RegionKey   INT NOT NULL,
	IsCity BIT DEFAULT 0,


	CONSTRAINT FK_District_Region
		FOREIGN KEY (RegionKey)
		REFERENCES DimRegion(RegionKey)
);
Exec sp_help DimDistrict;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--AGE GROUP DIMENSION(DimAgeGroup)
CREATE TABLE DimAgeGroup(
       AgeKey INT IDENTITY(1,1) PRIMARY KEY,
	   AgeGroup VARCHAR(50) NOT NULL UNIQUE,
	   MinAge INT,
	   MaxAge INT
);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--GENDER DIMESNSION(DimGender)
CREATE TABLE DimGender(
    GenderKey INT IDENTITY(1,1) PRIMARY KEY,
	Gender VARCHAR(10) NOT NULL UNIQUE 
);


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--MAIN FACT TABLE (FactMalria)
CREATE  TABLE FactMalaria (
  FACTID BIGINT IDENTITY(1,1) PRIMARY KEY,

  DateKey  INT NOT NULL,
  DistrictKey INT NOT NULL,
  RegionKey INT NOT NULL,
  AgeKey INT NOT NULL,
  GenderKey   INT NOT NULL,


  ConfirmedCases INT NOT NULL,
  TreatedCases INT NOT NULL,
  Population INT NOT NULL,


  LoadDate  DATETIME DEFAULT GETDATE(),


  CONSTRAINT FK_Fact_Date
		FOREIGN KEY (DateKey)
		REFERENCES DimDistrict(DistrictKey),


  CONSTRAINT FK_Fact_District
		FOREIGN KEY (DistrictKey)
		REFERENCES DimDistrict(DistrictKey),


  CONSTRAINT Fk_Fact_region
		FOREIGN KEY(RegionKey)
		REFERENCES DimRegion(RegionKey),

  CONSTRAINT Fk_Fact_Age
		FOREIGN KEY (AgeKey)
		REFERENCES DimAgeGroup(AgeKey),


  CONSTRAINT Fk_Fact_Gender
			FOREIGN KEY (GenderKey)
			REFERENCES DimGender(GenderKey)
);

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--SPATIAL STATISTICS(FactSpatialStats)

CREATE TABLE FactSpatialStats(

    SpatialID  INT IDENTITY(1,1) PRIMARY KEY,

	DistrictKey INT NOT NULL,
	DateKey    INT NOT NULL,


	MoranI   DECIMAL(10,6),
	Zscore   DECIMAL(10,4),
	PValue   DECIMAL(10,6),


	ClusterType    VARCHAR(20),

	CONSTRAINT FK_Spatial_District
			FOREIGN KEY (DistrictKey)
			REFERENCES DimDistrict(DistrictKey),

	CONSTRAINT FK_Spatial_Date 
			FOREIGN KEY (DateKey)
			REFERENCES DimDate(DateKey)
);

----------------------------------------------------------------------------------------------------------------------

--ETL Control Tables (Engineering Layer)
/**LOAD LOG **/
CREATE TABLE ETL_LoadLog(
		LoadID    INT IDENTITY  PRIMARY KEY,
		SourceFile  VARCHAR(200),
		StartTime   DATETIME,
		EndTime     DATETIME,
		Status      VARCHAR(20),
		RowsLoaded  INT,
		ErrorMsg    VARCHAR(500)
); 

--NOTE : ETL_LoadLog is used for auditing Loads 


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--DATA QUALITY  TABLE
CREATE TABLE DataQualityChecks(
		CheckID  INT IDENTITY PRIMARY KEY,
		CheckName VARCHAR(100),
		TableName  VARCHAR(100),
		IssueCount  INT,
		CheckDate  DATETIME
);

--This supports Governance.

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--INDEXING(PERFOMANCE)
CREATE NONCLUSTERED INDEX IX_Fact_Date
ON FactMalaria(DateKey);


CREATE NONCLUSTERED INDEX IX_Fact_District
ON FactMalaria(DistrictKey);

CREATE NONCLUSTERED INDEX IX_Fact_Region
ON FactMalaria(RegionKey);



--4/02/2026
--DROPPING WRONG/FAULTY CONSTRAINT
ALTER TABLE FactMalaria
DROP CONSTRAINT FK_Fact_Date;


--ADDING A CORRECTED CONSTRAINT KEY
ALTER TABLE FactMalaria 
ADD CONSTRAINT FK_Fact_Date 
	FOREIGN KEY (DateKey)
	REFERENCES DimDate(DateKey);


--05/02/2025
--Checking out the information about FactMalaria 
sp_help FactMalaria;



--Copying Malariadata into malaria DB 
SELECT *
INTO Malaria_DB.dbo.malaria_data1
FROM Practice1.dbo.malaria_data1;

SELECT * FROM malaria_data1;

=====================================================================================================================


--CREATING A STAGING LAYER
CREATE TABLE Stg_Malaria(
	Region VARCHAR(100),
	District VARCHAR(120),
	Year INT,
	Month INT,
	AgeGroup VARCHAR(50),
	Gender VARCHAR(10),

	ConfirmedCases INT,
	TreatedCases INT,
	Population INT

);


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--7/02/2026
--POPULATING DIMENSION TABLES(Date Dim, RegionDim, District Dim)


-- LOAD DATEDIMESION
INSERT INTO Dimdate
 SELECT DISTINCT
        Year*10000 + Month*100 + 1 AS DateKey,
		DATEFROMPARTS(Year, Month, 1),
		Year,
		DATEPART(QUARTER, DATEFROMPARTS(Year, Month, 1)),
		Month,
		DATENAME(MONTH, DATEFROMPARTS(Year,Month,1)),
		CONCAT(Year, '_', RIGHT('0' +CAST(Month AS VARCHAR), 2))
FROM Stg_Malaria;


======================================================================================================================================


--LOAD DimensionRegion
INSERT INTO DimRegion
		SELECT DISTINCT Region
		FROM Stg_Malaria;

--Confirming Dimension table information for Regions
SELECT * FROM DimRegion;

=======================================================================================================================================
--LOAD District Dimension
INSERT INTO DimDistrict(DistrictName, RegionKey)
		SELECT DISTINCT
		s.District,
		r.RegionKey
FROM Stg_Malaria s
JOIN DimRegion r
     ON s.Region = r.Region
WHERE NOT EXISTS (
	SELECT 1 FROM DimDistrict d 
	WHERE d.Districtname = s.District
);

--Confirm data Inside the dimension table
SELECT * FROM DimDistrict;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--LOAD AGE GROUPS (We dont have 
INSERT INTO DimAgeGroup 
SELECT DISTINCT 

===========================================================================================================================================
--LOAD FACT TABLE
INSERT INTO FactMalaria
(
DateKey,
DistrictKey,
RegionKey,
RegionKey,
AgeKey,
GenderKey,
ConfirmedCases,
TreatedCases,
Population
)
SELECT 
  d.DateKey,
  di.DistrictKey,
  r.RegionKey,
  a.AgeKey,
  g.GenderKey,

  s.ConfirmedCases,
  s.TreatedCases,
  s.Population

FROM Stg_Malaria s

JOIN DimRegion r
ON r.Region  =  s.rEGION

JOIN DimDistrict di
     ON di.DistrictName = s.District

JOIN DimAgeGroup a
ON a.AgeGroup = s.AgeGroup

JOIN DimGender g
ON g.Gender = s.Gender;


