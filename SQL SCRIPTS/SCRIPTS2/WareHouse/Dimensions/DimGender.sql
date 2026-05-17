USE MalariaWareHouse_DB;

---GENDER DIMENSION(DimGender)
CREATE TABLE DimGender(
GenderKey INT PRIMARY KEY,
Gender VARCHAR(10) NOT NULL UNIQUE
);
GO 

EXEC sp_fkeys DimGender;


ALTER TABLE DimGender
DROP CONSTRAINT PK__DimGende__44C092CDB561F2FA;

ALTER TABLE DimGender DROP COLUMN GenderKey;

ALTER TABLE DimGender ADD GenderKey INT IDENTITY(1,1) PRIMARY KEY;
SELECT * FROM DimGender;

/**Ingesting Data Into DimGender**/

INSERT INTO DimGender(Gender)
SELECT  DISTINCT Gender FROM
[MalariaLanding_DB].dbo.Stg_Malaria_Permanent;

SELECT * FROM DimGender;




