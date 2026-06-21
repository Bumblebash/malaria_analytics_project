USE MalariaWareHouse_DB;




CREATE TABLE DimDistrict(
	DistrictKey INT IDENTITY(1,1) PRIMARY KEY,
	DistrictName NVARCHAR(120) NOT NULL,
	RegionKey INT NOT NULL,
	IsCity BIT DEFAULT 0,

---SCD2 Tracking Columns
ValidFrom DATE NOT NULL,
ValidTo DATE NULL,
IsCurrent BIT DEFAULT 1,

--Constraint
CONSTRAINT FK_District_Region
     FOREIGN KEY(RegionKey)
     REFERENCES DimRegion(RegionKey)
);

SELECT * FROM DimDistrict;
/**Insertion of data into the DimDistrict**/
INSERT INTO DimDistrict (DistrictName, RegionKey, IsCity, ValidFrom , ValidTo, IsCurrent)
SELECT DISTINCT
        s.District,
		r.RegionKey,
		CASE 
			WHEN s.District LIKE '%City%' THEN 1
			ELSE 0
		END AS IsCity
FROM [MalariaLanding_DB].dbo.Stg_Malaria_Permanent s 
JOIN DimRegion r ON s.Region = r.Region
WHERE s.District LIKE '%District%'
      OR s.District LIKE '%City%'
	  AND s.Region <> s.District;



ALTER TABLE DimDistrict DROP CONSTRAINT FK_District_Region;
DROP TABLE DimDistrict;


SELECT * FROM DimDistrict;
	
EXEC sp_help DimDistrict;