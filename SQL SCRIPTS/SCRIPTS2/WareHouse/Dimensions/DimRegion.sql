USE MalariaWareHouse_DB;

--CREATING Region Dimesion
CREATE TABLE DimRegion(
   RegionKey INT IDENTITY(1,1) PRIMARY KEY,
   Region VARCHAR(20) NOT NULL UNIQUE

);
GO

