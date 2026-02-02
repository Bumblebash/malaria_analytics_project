USE PRACTICE1;
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

--Confirming 
Exec sp_help DimDate;