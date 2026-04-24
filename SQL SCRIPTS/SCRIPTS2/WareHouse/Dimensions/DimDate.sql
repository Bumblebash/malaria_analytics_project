USE MalariaWareHouse_DB;

------Creating  Date Dimesion(DateDim)
CREATE TABLE DimDate(
	DateKey INT PRIMARY KEY,
	FullDate DATE NOT NULL,
	Year INT NOT NULL,
	Quarter INT NOT NULL,
	Month INT NOT NULL,
	MonthName NVARCHAR(20),
	YearMonth VARCHAR(8)
);
GO 

---Confirming Datatypes of Columns
EXEC sp_help DimDate

