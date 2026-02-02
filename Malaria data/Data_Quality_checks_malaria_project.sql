USE Practice1;

--Retrieving Data from database for malaria demorgraphics
SELECT * FROM malaria_data;

-----Total Population From North Central for year 2024
SELECT 
    Region,
    SUM(TotalPopulation) AS totalpn
FROM malaria_data
    WHERE Region = 'North Central' AND YEAR = '2024'
GROUP BY Region;

------------------------------------------------------------------------------------------------------------------------------------------------------
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

 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 --Confirming Information for Masaka City and Masaka District
 SELECT *
 FROM malaria_data
 WHERE District IN ('Masaka City', 'Masaka District')  AND Year = '2024';


 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ---Confirming Total population  for Lango Region
 SELECT 
        Region,
        SUM(TotalPopulation) AS totalpn
        FROM malaria_data 
        WHERE YEAR = 2024   AND District  IN  ('Alebtong District','Lira City','Amolatar District', 'Apac District', 'Dokolo District'
        ,'Kole District', 'Kwania District', 'Lira District', 'Otuke District', 'Oyam District')
    GROUP BY Region
        ;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Confirming Total Population for Masaka City
 SELECT 
      SUM(TotalPopulation) AS Totalpn
FROM malaria_data
           WHERE YEAR = 2024
           AND District = 'Masaka City';

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---Total Cases Confirmed( B/S & RDT) for South Central Region 
SELECT  
    Region , 
    SUM(TotalCasesConfirmed_BSRDT) as TotalCASES 
FROM malaria_data
    WHERE Region = District AND Region = 'South Central' AND YEAR = 2024
    GROUP BY Region;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----Confirming Total Population For masaka City
SELECT 
    District,  
    TotalPopulation
FROM malaria_data 
    WHERE District = 'Masaka City' AND Year = '2020'
   ;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Confirming Total Cases for Masaka City 
SELECT  
        District,
        TotalCasesConfirmed_BSRDT
FROM malaria_data
    WHERE YEAR = 2020
    AND District = 'Masaka City';

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Calculating the Average Incidence Rate for year 2024
SELECT  AVG(IncidenceRate) AS avg_incidence FROM malaria_data
WHERE Year = '2024' AND Region =District
;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------



--4/01/2026
--Confirming Maximum Count of Total Cases(B/S & RDT)
SELECT  MIN(TOTAlCasesConfirmed_BSRDT) Max_Case_recorded FROM malaria_data
     WHERE District = Region
     AND TOTAlCasesConfirmed_BSRDT > 0 ;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Confirming Minimum Count of Total Cases(B/S & RDT)
SELECT  MIN(TOTAlCasesConfirmed_BSRDT) Max_Case_recorded FROM malaria_data
            WHERE TOTAlCasesConfirmed_BSRDT > 0;



-- Records with Just Zero For Total Cases Confirmed
SElect * from malaria_data 
            WHERE TOTAlCasesConfirmed_BSRDT = 0;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--5/01/2026
---Extracting out Year Over Year Change(YoY) %age Change For Regions 
/**METHOD I **/
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
       /**NOTE**/ --The problem with this query is that it truncates the final Y_0_Y_Change to whole number yet we wanted  to 2 dps **/

 -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


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
   / CAST(Previous_Total_Cases AS DECIMAL(18,2)) * 100, 2) 
   AS DECIMAL(18,2) )   ---Logic in division 
       END AS Y_0_Y_Change
       FROM previous_year_cte;

       /**NOTE**/ --This is a good query as the final result is to 2dps

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Confirming   Datatypes 
EXEC sp_help 'malaria_data';

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


/**Extracting Cases Treated Vs Cases Confirmed**/

WITH treated_cases_cte AS (
    SELECT 
           Region, 
           Year,
           TOTAlCasesConfirmed_BSRDT As Total_Cases,
           SUM([0_28Days_CT_Total] + 
           [29Days_4Yrs_CT_Total] + 
           [5_9YRS_CT_Total] + 
           [10_19YRS_CT_Total] + 
           [20+YRS_CT_Total]) As total_Cases_Treated 
        FROM malaria_data 
           WHERE Region = District AND Region <> '0'
        GROUP BY Region,TOTAlCasesConfirmed_BSRDT, Year
   )
       SELECT
            n, 
           Year, 
           Total_Cases, 
           total_Cases_Treated, 
           CAST(ROUND( (CAST((total_Cases_Treated) AS DECIMAL(18,2))/ CAST((Total_Cases) AS Decimal(18,2)) ) * 100, 2) AS DECIMAL(18,2)) As Percentage_Treatment_Coverage 
                    FROM treated_cases_cte
                 ORDER BY region , Year;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/**13/01/2026**/
--Cases Treated Vs Cases Confirmed 

WITH treated_cases_cte AS (
SELECT 
       Year,
       SUM(TOTAlCasesConfirmed_BSRDT) As Total_Cases,
       SUM([0_28Days_CT_Total] + 
       [29Days_4Yrs_CT_Total] + 
       [5_9YRS_CT_Total] + 
       [10_19YRS_CT_Total] + 
       [20+YRS_CT_Total]) As total_Cases_Treated 
    FROM malaria_data 
       WHERE Region = District AND Region <> '0'
    GROUP BY  Year
   
   )
     SELECT 
       Year, 
       Total_Cases, 
       total_Cases_Treated, 
       CAST(ROUND( (CAST((total_Cases_Treated) AS DECIMAL(18,2))/ CAST((Total_Cases) AS Decimal(18,2)) ) * 100, 2) AS DECIMAL(18,2)) As Percentage_Treatment_Coverage 
 FROM treated_cases_cte
     ORDER BY  Year;

 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Considering  GrandTotal Cases

WITH treated_cases_cte AS (
    SELECT 
           Year,
           SUM(TOTAlCasesConfirmed_BSRDT) As Total_Cases_Confirmed,
           SUM(GrandTotalCases) As Total_Cases,
           SUM([0_28Days_CT_Total] + 
           [29Days_4Yrs_CT_Total] + 
           [5_9YRS_CT_Total] + 
           [10_19YRS_CT_Total] + 
           [20+YRS_CT_Total]) As total_Cases_Treated 
     FROM malaria_data 
           WHERE Region = District AND Region <> '0'
     GROUP BY  Year
   
   )
       SELECT 
           Year, 
           Total_Cases,
           Total_Cases_Confirmed,
           total_Cases_Treated, 
           CAST(ROUND( (CAST((total_Cases_Treated) AS DECIMAL(18,2))/ CAST((Total_Cases) AS Decimal(18,2)) ) * 100, 2) AS DECIMAL(18,2)) As Percentage_Treatment_Coverage 
        FROM treated_cases_cte
        ORDER BY  Year;




--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/**Less than 5 yrs Burden By percentage **/ 
      --Confirming U5 yrs totals(B/&RDT)
      --Fetching only Cases Confirmed By B/S & RDT
WITH Total_cases_cte AS(
SELECT 
       Region, 
       Year,
       TOTAlCasesConfirmed_BSRDT As Total_Cases,
       SUM(
       [0_28Days(BSRDT)_Total]+
       [29Days_4Yrs(BSRDT)_Total]
       ) AS U5TotalCases
    FROM malaria_data 
       WHERE Region = District AND Region <> '0' 
    GROUP BY Region, Year, TOTAlCasesConfirmed_BSRDT
    )
    SELECT Region, 
        Year, 
        Total_Cases, 
        U5TotalCases,
        CAST(ROUND((CAST((U5TotalCases) AS DECIMAL(18,2)) / CAST((Total_Cases) AS DECIMAL (18,2) )) * 100,2) AS DECIMAL(18,2)) AS U5YrBurden
    FROM Total_cases_cte
    ORDER BY  Region,Year ASC;

------------------------------------------------------------------------------------------------------------------------------------------------------------------

--U5 Cases per Year Strictly

WITH Total_cases_cte AS(
SELECT
       Year,
      SUM( TOTAlCasesConfirmed_BSRDT ) As Total_Cases,
       SUM(
       [0_28Days(BSRDT)_Total]+
       [29Days_4Yrs(BSRDT)_Total]
       ) AS U5TotalCases
 FROM malaria_data 
       WHERE Region = District AND Region <> '0' 
    GROUP BY  Year
    )
 SELECT 
     Year, 
     Total_Cases, 
     U5TotalCases,
     CAST(ROUND((CAST((U5TotalCases) AS DECIMAL(18,2)) / CAST((Total_Cases) AS DECIMAL (18,2) )) * 100,2) AS DECIMAL(18,2)) AS U5YrBurden
 FROM Total_cases_cte
      ORDER BY Year ASC;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/** Confirming Total Cases Confirmed By BS & RDT As Per Lamwo District**/
SELECT TOTAlCasesConfirmed_BSRDT AS Total_Cases
        FROM malaria_data
        WHERE  District like '%district%' AND District = 'Lamwo District'
         AND year = 2020;


--10/10/206
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*Extraction Percentage  Burden in PRegnant Women**/

WITH Preg_cte AS(
SELECT Region , 
       Year, 
       SUM(Preg_Total) As total_Preg_Cases ,  
       TOTAlCasesConfirmed_BSRDT AS total_Cases 
    FROM malaria_data 
    WHERE Region = District AND Region <> '0'
    GROUP BY Year, Preg_Total, Region, TOTALCasesConfirmed_BSRDT
        )
 SELECT 
     Region, 
     Year, 
     total_Preg_Cases,
     total_Cases, 
     CAST(ROUND(CAST((total_Preg_Cases) AS DECIMAL(18,2))/  CAST((total_Cases) AS DECIMAL(18,2)) * 100, 2) AS DECIMAL(18,2)) AS Preg_Percentage
   FROM Preg_cte
   ORDER BY Region ASC;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*
-PercentagePregnant Cases Per Year From 2020-2024 **/
WITH Preg_cte AS(
    SELECT  
           Year, 
           SUM(Preg_Total) As total_Preg_Cases ,  
           SUM(TOTAlCasesConfirmed_BSRDT) AS total_Cases 
        FROM malaria_data 
        WHERE Region = District AND Region <> '0'
        GROUP BY Year
            )
     SELECT 
 
         Year, 
         total_Preg_Cases,
         total_Cases, 
         CAST(ROUND(CAST((total_Preg_Cases) AS DECIMAL(18,2))/  CAST((total_Cases) AS DECIMAL(18,2)) * 100, 2) AS DECIMAL(18,2)) AS Preg_Percentage
   FROM Preg_cte
;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------

--11/01/2025
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   --ADULTS (10-20+YRS)
/**Extracting Percentage Burden in Adults Per Year Per Region*/
--(10-19yrs) & (20+Yrs) Age Bracket
WITH adult_cte AS(
    SELECT 
  Region , 
        Year,
         TOTAlCasesConfirmed_BSRDT AS total_Cases, 
        SUM([10_19YRS(BSRDT)_Total] + [20+YRS_(BSRDT)_Total]) AS Total_Adult_Cases
FROM malaria_data
    WHERE Region = District AND Region <> '0'
    GROUP BY Region, Year, TOTAlCasesConfirmed_BSRDT
    )

    SELECT Region,
           Year,
           total_cases,
           Total_Adult_Cases,
           CAST(ROUND(((CAST((Total_Adult_Cases) AS DECIMAL(18,2)) / CAST((total_cases) AS DECIMAl(18,2))) * 100),2) AS DECIMAL(18,2)) AS Adult_percentage
    FROM adult_cte ;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --Strictly Percentage by Age Group (ADULT) Per Year 

    WITH adult_cte AS(
SELECT 
    Year,
     SUM(TOTAlCasesConfirmed_BSRDT) AS total_Cases, 
    SUM([10_19YRS(BSRDT)_Total] + [20+YRS_(BSRDT)_Total]) AS Total_Adult_Cases
FROM malaria_data
    WHERE Region = District AND Region <> '0'
    GROUP BY  Year
    )

    SELECT
           Year,
           total_cases,
           Total_Adult_Cases,
           CAST(ROUND(((CAST((Total_Adult_Cases) AS DECIMAL(18,2)) / CAST((total_cases) AS DECIMAl(18,2))) * 100),2) AS DECIMAL(18,2)) AS Adult_percentage
    FROM adult_cte ;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------           
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--5-9YRS AGE CATEGORY 
/**Extracting Percentage Burden in 5-9yRs Age Group  Per Year Per Region (5-9YRS)**/

--Percentage by Region by Age_group(5_9yrs) by Year 
WITH total_Cases_cte AS(
        SELECT 
        Region, 
        Year, 
        TOTAlCasesConfirmed_BSRDT As total_cases, SUM([5_9YRS(BSRDT)_Total]) AS [total_cases_btn(5_9)] 
    FROM malaria_data
        WHERE Region = District AND Region <> '0'
        GROUP BY Region , Year, TOTAlCasesConfirmed_BSRDT
)
    SELECT 
         Region,  
         Year, 
         total_cases, [total_cases_btn(5_9)] , 
         CAST( ROUND((CAST([total_cases_btn(5_9)] AS DECIMAL(18,2)) / CAST( total_cases AS DECIMAL(18,2)) * 100),2) AS DECIMAL(18,2)) AS [5_9_yrs_by_percentage]
    FROM total_Cases_cte ;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


    --Percentage  By Year(Strictly) per 5_9_Yrs_By_Percentage
    WITH total_Cases_cte AS(
        SELECT 
        Year, 
        SUM(TOTAlCasesConfirmed_BSRDT) As total_cases, SUM([5_9YRS(BSRDT)_Total]) AS [total_cases_btn(5_9)] 
    FROM malaria_data
        WHERE Region = District AND Region <> '0'
        GROUP BY Year
)
    SELECT 
         
         Year, 
         total_cases, [total_cases_btn(5_9)] , 
         CAST( ROUND((CAST([total_cases_btn(5_9)] AS DECIMAL(18,2)) / CAST( total_cases AS DECIMAL(18,2)) * 100),2) AS DECIMAL(18,2)) AS [5_9_yrs_by_percentage]
    FROM total_Cases_cte ;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


---PERCENTAGE BY GENDER
----FEMALE & MALE

 WITH total_Cases_cte AS(
        SELECT 
        Year,  
        SUM(TOTAlCasesConfirmed_BSRDT) As total_cases,
        SUM([0_28Days(BSRDT)_Female] +
             [29Days_4Yrs(BSRDT)_Female]+
             [5_9YRS(BSRDT)_Female]+
             [10_19YRS(BSRDT)_Female]+
             [20+YRS_(BSRDT)_Female]) AS Total_female_Cases,
        SUM([0_28Days(BSRDT)_Male] +
             [29Days_4Yrs(BSRDT)_Male]+
             [5_9YRS(BSRDT)_Male]+
             [10_19YRS(BSRDT)_Male]+
             [20+YRS_(BSRDT)_Male]) AS Total_Male_Cases
    FROM malaria_data
        WHERE Region = District AND Region <> '0'
        GROUP BY Year
)
    SELECT 
         
         Year, 
         total_cases, Total_female_Cases, Total_Male_Cases,
         CAST( ROUND((CAST([Total_female_Cases] AS DECIMAL(18,2)) / CAST( total_cases AS DECIMAL(18,2)) * 100),2) AS DECIMAL(18,2)) AS Percentage_Total_Cases_Female,
         CAST( ROUND((CAST([Total_Male_Cases] AS DECIMAL(18,2)) / CAST( total_cases AS DECIMAL(18,2)) * 100),2) AS DECIMAL(18,2)) AS Percentage_Total_Cases_Male
    FROM total_Cases_cte ;

    ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--15/01/2025
--Confirming Malaria Cases Confirmed for Kampala 2021 and 2020
SELECT TOTAlCasesConfirmed_BSRDT AS total_cases ,
 District 
 FROM malaria_data
 WHERE  Year = '2020' AND DISTRICT = 'Kampala district' ;


 SELECT TOTAlCasesConfirmed_BSRDT AS total_cases ,
Region
 FROM malaria_data
 WHERE  Year = '2021' AND Region = 'Kampala' AND District = Region;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--16/01/2026
--Confirming Cases Treated as per 2021
 SELECT 
       SUM([0_28Days_CT_Total] + 
       [29Days_4Yrs_CT_Total] + 
       [5_9YRS_CT_Total] + 
       [10_19YRS_CT_Total] + 
       [20+YRS_CT_Total]) As total_Cases_Treated 
    FROM malaria_data 
    WHERE Year = 2021
    ;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---20/01/2025
--Confirming Incidence Rates Per Region
 SELECT Region, SUM(IncidenceRate) As Total_Incidence_Rates, Year
    FROM malaria_data
    WHERE Region = District AND Year = 2024 AND Region = 'North Central'
    GROUP BY Region, Year;

 -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--TOTAlCasesConfirmed_BSRDT 
---Confirming Total population of North central for 2021
SELECT District, TotalPopulation
FROM malaria_data WHERE   District = 'Wakiso District' AND YEAR = 2021 AND  District like  '%district%'
;


