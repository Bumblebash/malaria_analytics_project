USE Malaria_DB;

===============================================================================================================================
--CheckOut the Number of Columns in Each raw File

SELECT 
      COUNT(*) AS NumberOfColumns 
FROM 
    INFORMATION_SCHEMA.COLUMNS 
WHERE 
     TABLE_NAME = 'Malaria2023'
     AND TABLE_SCHEMA = 'dbo';

========================================================================================================================

SELECT * FROM Malaria2024;

SELECT * from stg_malaria;