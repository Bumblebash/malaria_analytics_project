USE Practice1;


SELECT * FROM malaria_data;

--Total Population From Acholi for year 2020
SELECT Region, SUM(TotalPopulation) AS totalpn
FROM malaria_data
WHERE Region = 'North Central' AND YEAR = '2024'
GROUP BY Region;


--Total Population From Acholi for year 2020
SELECT *
FROM malaria_data
WHERE Region = District AND Region = 'South Central' AND YEAR = '2024';


--Number of Districts in North Central 
SELECT Region, COUNT(District) As total_Districts
 FROM malaria_data
 WHERE  Region = 'North Central' AND Year = '2024'
 GROUP BY Region;

 SELECT *
 FROM malaria_data
 WHERE  Region = 'South Central' AND Year = '2024'
 ;


 --Confirming Information for Masaka City and Masaka District
 SELECT *
 FROM malaria_data
 WHERE District IN ('Masaka City', 'Masaka District')  AND Year = '2024';



 ---Confirming Information for Lango
 SELECT  SUM(TotalPopulation) AS totalpn
        FROM malaria_data 
        WHERE YEAR = 2024   AND District  IN  ('Alebtong District','Lira City','Amolatar District', 'Apac District', 'Dokolo District'
        ,'Kole District', 'Kwania District', 'Lira District', 'Otuke District', 'Oyam District'
        )
        ;
--Confirming for Masaka City
 SELECT SUM(TotalPopulation) AS Totalpn
           FROM malaria_data
           WHERE YEAR = 2024
           AND District = 'Masaka City';

---Total Cases Confirmed By R/D and BS for South Central
SELECT  Region , SUM(TotalCasesConfirmed_BSRDT) as TotalCASES 
FROM malaria_data
    WHERE Region = District AND Region = 'South Central' AND YEAR = 2024
    GROUP BY Region;

    ----Confirming Total Population without masaka City
    SELECT District,  TotalPopulation
    FROM malaria_data 
    WHERE District = 'Masaka City' AND Year = '2020'
   ;


--Confirming Total Cases for Masaka City 
SELECT  TotalCasesConfirmed_BSRDT
           FROM malaria_data
           WHERE YEAR = 2020
           AND District = 'Masaka City';


SELECT  AVG(IncidenceRate) AS avg_incidence FROM malaria_data

WHERE Year = '2024'

;





--4/01/2026
--Confirming Maximum Count of RDT & BS
SELECT  MIN(TOTAlCasesConfirmed_BSRDT) Max_Case_recorded FROM malaria_data
     WHERE District = Region
     AND TOTAlCasesConfirmed_BSRDT > 0 ;


--Confirming Minimum Count of RDT & BS
SELECT  MIN(TOTAlCasesConfirmed_BSRDT) Max_Case_recorded FROM malaria_data
            WHERE TOTAlCasesConfirmed_BSRDT > 0;


-- Records with Just Zero For Total Cases Confirmed
SElect * from malaria_data 
            WHERE TOTAlCasesConfirmed_BSRDT = 0;

--5/01/2025
---Extracting out Year Over Year Change(YoY) %age Change For Regions 
WITH previous_year_cte AS(
  SELECT Region, Year, TOTAlCasesConfirmed_BSRDT As Current_Total_Cases, 
       LAG(TOTAlCasesConfirmed_BSRDT) OVER(PARTITION BY Region ORDER BY Year) As Previous_Total_Cases
       FROM malaria_data 
       WHERE Region = District
       )
SELECT Region, Year, Current_Total_Cases, Previous_Total_Cases,
       CASE WHEN Previous_Total_Cases IS NULL THEN NULL --For the Fiest Year
       WHEN Previous_Total_Cases = 0 THEN NULL  --Avoids Division By Zero
       ELSE 
    ROUND((Current_Total_Cases - Previous_Total_Cases) * 100 / Previous_Total_Cases , 2)  ---Logic in division 
       END AS Y_0_Y_Change
       FROM previous_year_cte;


    /** METHOD II **/
WITH previous_year_cte AS(
  SELECT Region, Year, TOTAlCasesConfirmed_BSRDT As Current_Total_Cases, 
       LAG(TOTAlCasesConfirmed_BSRDT) OVER(PARTITION BY Region ORDER BY Year) As Previous_Total_Cases
       FROM malaria_data 
       WHERE Region = District AND Region <> '0' AND Region IS NOT NULL
       )
SELECT Region, Year, Current_Total_Cases, Previous_Total_Cases,
       CASE WHEN Previous_Total_Cases IS NULL THEN NULL --For the First Year
       WHEN Previous_Total_Cases = 0 THEN NULL  --Avoids Division By Zero
       ELSE 
 CAST(ROUND(
   (CAST(Current_Total_Cases AS DECIMAL(18,2)) --- Assign Every Column with Cast AS DECIMAL(18,2)
    - CAST(Previous_Total_Cases AS DECIMAL(18,2)))
   / CAST(Previous_Total_Cases AS DECIMAL(18,2)) * 100, 
2) AS DECIMAL(18,2) )   ---Logic in division 
       END AS Y_0_Y_Change
       FROM previous_year_cte;


--Confirming   Datatypes 
EXEC sp_help 'malaria_data';









