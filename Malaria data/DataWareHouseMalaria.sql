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



sp_help FactMalaria;


