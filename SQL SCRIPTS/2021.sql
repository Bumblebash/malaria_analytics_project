USE Malaria_DB;


EXEC  sp_rename '2021_csv', 'malaria_data_2021';
SELECT *FROM malaria_data_2021;

EXEC sp_rename 'malaria_data_2021.column1', 'CT_0_28Days', 'column';
EXEC sp_rename 'malaria_data_2021.column2', 'CT_10_19yrs', 'column';
EXEC sp_rename 'malaria_data_2021.column3', 'CT_20+yrs', 'column';
EXEC sp_rename 'malaria_data_2021.column4', 'CT_29Days_4yrs', 'column';
EXEC sp_rename 'malaria_data_2021.column5', 'CT_5_9yrs', 'column';
EXEC sp_rename 'malaria_data_2021.column6', 'Region', 'column';
EXEC sp_rename 'malaria_data_2021.column7', 'District', 'column';

--Eliminating the Unwanted Column headers
SELECT TOP(1) * FROM malaria_data_2021;

DELETE  TOP(1)  FROM malaria_data_2021;

--Changing datatypes
ALTER TABLE malaria_data_2021 ALTER COLUMN [CT_0_28Days] INT;
ALTER TABLE malaria_data_2021 ALTER COLUMN [CT_10_19yrs] INT;
ALTER TABLE malaria_data_2021 ALTER COLUMN [CT_20+yrs] INT;
ALTER TABLE malaria_data_2021 ALTER COLUMN [CT_5_9yrs] INT;
ALTER TABLE malaria_data_2021 ALTER COLUMN [CT_29Days_4yrs] INT;


EXEC sp_help malaria_data_2021;


SELECT SUM([CT_0_28Days]+ [CT_10_19yrs]+ [CT_29Days_4yrs] + [CT_5_9yrs] + [CT_20+yrs]) As total_cases
FROM malaria_data_2021
WHERE 
Region = District ;
