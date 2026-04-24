USE MalariaWareHouse_DB;

CREATE TABLE DimDistrict(
DistrictKey INT IDENTITY(1,1) PRIMARY KEY,
DistrictName NVARCHAR(120) NOT NULL,
RegionKey INT NOT NULL,
IsCity BIT DEFAULT 0,

--Constraint
CONSTRAINT FK_District_Region
     FOREIGN KEY(RegionKey)
     REFERENCES DimRegion(RegionKey)

);