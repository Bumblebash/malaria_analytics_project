USE Malaria_DB;

--19/02/2026
--INSERTING/INGESTION OF DATA INTO STAGING LAYER

--2020DATA



--13/02/2026
--DROPPING FAULTY CONTENT INSIDE Staging Table
TRUNCATE TABLE Stg_Malaria;

WITH Unpivoted AS(
		SELECT 
			[orgunitlevel2] AS Region,
			[organisationunitname] AS District,
			ColName,
			Value,
			Population
		FROM Malaria2020
		UNPIVOT (
			value FOR ColName IN (
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 0-28Dys, Female January 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 0-28Dys, Female February 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 0-28Dys, Female March 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 0-28Dys, Female April 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 0-28Dys, Female May 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 0-28Dys, Female June 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 0-28Dys, Female July 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 0-28Dys, Female August 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 0-28Dys, Female September 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 0-28Dys, Female October 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 0-28Dys, Female November 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 0-28Dys, Female December 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 0-28Dys, Male January 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 0-28Dys, Male February 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 0-28Dys, Male March 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 0-28Dys, Male April 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 0-28Dys, Male May 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 0-28Dys, Male June 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 0-28Dys, Male July 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 0-28Dys, Male August 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 0-28Dys, Male September 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 0-28Dys, Male October 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 0-28Dys, Male November 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 0-28Dys, Male December 2020],
		
			    [105-EP01c. Malaria Confirmed (B/s and RDT Positive) 10-19Yrs, Female January 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 10-19Yrs, Female February 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 10-19Yrs, Female March 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 10-19Yrs, Female April 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 10-19Yrs, Female May 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 10-19Yrs, Female June 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 10-19Yrs, Female July 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 10-19Yrs, Female August 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 10-19Yrs, Female September 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 10-19Yrs, Female October 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 10-19Yrs, Female November 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 10-19Yrs, Female December 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 10-19Yrs, Male January 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 10-19Yrs, Male February 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 10-19Yrs, Male March 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 10-19Yrs, Male April 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 10-19Yrs, Male May 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 10-19Yrs, Male June 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 10-19Yrs, Male July 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 10-19Yrs, Male August 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 10-19Yrs, Male September 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 10-19Yrs, Male October 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 10-19Yrs, Male November 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 10-19Yrs, Male December 2020],
				
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 20+Yrs, Male January 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 20+Yrs, Male February 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 20+Yrs, Male March 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 20+Yrs, Male April 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 20+Yrs, Male May 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 20+Yrs, Male June 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 20+Yrs, Male July 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 20+Yrs, Male August 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 20+Yrs, Male September 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 20+Yrs, Male October 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 20+Yrs, Male November 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 20+Yrs, Male December 2020],

				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 20+Yrs, Female January 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 20+Yrs, Female February 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 20+Yrs, Female March 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 20+Yrs, Female April 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 20+Yrs, Female May 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 20+Yrs, Female June 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 20+Yrs, Female July 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 20+Yrs, Female August 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 20+Yrs, Female September 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 20+Yrs, Female October 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 20+Yrs, Female November 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 20+Yrs, Female December 2020],
				
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 29Dys-4Yrs, Female January 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 29Dys-4Yrs, Female February 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 29Dys-4Yrs, Female March 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 29Dys-4Yrs, Female April 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 29Dys-4Yrs, Female May 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 29Dys-4Yrs, Female June 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 29Dys-4Yrs, Female July 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 29Dys-4Yrs, Female August 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 29Dys-4Yrs, Female September 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 29Dys-4Yrs, Female October 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 29Dys-4Yrs, Female November 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 29Dys-4Yrs, Female December 2020],
	            [105-EP01c. Malaria Confirmed (B/s and RDT Positive) 29Dys-4Yrs, Male January 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 29Dys-4Yrs, Male February 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 29Dys-4Yrs, Male March 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 29Dys-4Yrs, Male April 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 29Dys-4Yrs, Male May 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 29Dys-4Yrs, Male June 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 29Dys-4Yrs, Male July 2020],
			    [105-EP01c. Malaria Confirmed (B/s and RDT Positive) 29Dys-4Yrs, Male August 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 29Dys-4Yrs, Male September 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 29Dys-4Yrs, Male October 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 29Dys-4Yrs, Male November 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 29Dys-4Yrs, Male December 2020],


				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 5-9Yrs, Male January 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 5-9Yrs, Male February 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 5-9Yrs, Male March 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 5-9Yrs, Male April 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 5-9Yrs, Male May 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 5-9Yrs, Male June 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 5-9Yrs, Male July 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 5-9Yrs, Male August 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 5-9Yrs, Male September 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 5-9Yrs, Male October 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 5-9Yrs, Male November 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 5-9Yrs, Male December 2020],

				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 5-9Yrs, Female January 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 5-9Yrs, Female February 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 5-9Yrs, Female March 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 5-9Yrs, Female April 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 5-9Yrs, Female May 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 5-9Yrs, Female June 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 5-9Yrs, Female July 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 5-9Yrs, Female August 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 5-9Yrs, Female September 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 5-9Yrs, Female October 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 5-9Yrs, Female November 2020],
				[105-EP01c. Malaria Confirmed (B/s and RDT Positive) 5-9Yrs, Female December 2020]
		
	)
	) u
),
Parsed AS (
   SELECT 
       Region,
	   District,
	   Value AS ConfirmedCases,
	   CAST(RIGHT(ColName, 4) AS INT) AS Year,
	   Population,
	   CASE 
	      WHEN ColName LIKE '%January%' THEN 1
		  WHEN ColName LIKE '%February%' THEN 2
		  WHEN ColName LIKE '%March%' THEN 3
		  WHEN ColName LIKE '%April%' THEN 4
		  WHEN ColName LIKE '%May%' THEN 5
		  WHEN ColName LIKE '%June%' THEN 6
		  WHEN ColName LIKE '%July%' THEN 7
		  WHEN ColName LIKE '%August%' THEN 8
		  WHEN ColName LIKE '%September%' THEN 9
		  WHEN ColName LIKE '%October%' THEN 10
		  WHEN ColName LIKE '%November%' THEN 11
		  WHEN ColName LIKE '%December%' THEN 12
		END AS Month,

		--AGE GROUP
		CASE 
			WHEN ColName LIKE '%0-28Dys%' THEN '0-28Dys'
			WHEN ColName LIKE '%29Dys-4yrs%' THEN '29Days-4yrs'
			WHEN ColName LIKE '%5-9yrs%' THEN '5-9yrs'
			WHEN ColName LIKE '%10-19Yrs%' THEN '10-19yrs'
			WHEN ColName LIKE '%20+Yrs%' THEN '20+'
		END AS AgeGroup,

		--GENDER
		CASE 
			WHEN ColName LIKE '%Female%' THEN 'Female'
			WHEN ColName LIKE '%Male%' THEN 'Male'
		END AS Gender 
	FROM Unpivoted
)
--INSERTING RAW DATA INTO Staging Layer From Parse table
INSERT INTO Stg_Malaria(
		Region,
		District,
		Year,
		Month,
		AgeGroup,
		Gender,
		ConfirmedCases,
		Population 
)
SELECT 
	Region,
	District,
	Year,
	Month,
	AgeGroup,
	Gender,
	ConfirmedCases,
	Population
FROM Parsed
WHERE ConfirmedCases IS NOT NULL;



TRUNCATE TABLE Stg_Malaria;
SELECT  * FROM Malaria2023;
SELECT * FROM Stg_Malaria;

SELECT * FROM Stg_Malaria
WHERE Population IS NULL;

SELECT * FROM Fact_Malaria;

SELECT * FROM Malaria2020;