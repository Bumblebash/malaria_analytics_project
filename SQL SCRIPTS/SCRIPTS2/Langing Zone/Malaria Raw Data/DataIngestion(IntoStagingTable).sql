
USE MalariaLanding_DB;

USE MalariaAudit;
---DATA INGESTION INTO THE PERMANENT STAGING TABLE

DECLARE @cols NVARCHAR(MAX);

----- Build dynamic column list from source table
    SELECT @cols = STRING_AGG(CAST(QUOTENAME(COLUMN_NAME) AS NVARCHAR(MAX)), ',')
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'Malaria2024'
      AND (
           COLUMN_NAME LIKE '105-EP01c%'   -- Confirmed Cases
           OR COLUMN_NAME LIKE '105-EP01d%' -- Treated Cases
           OR COLUMN_NAME LIKE '105-MC04%'  -- Malaria in pregnancy
           OR COLUMN_NAME LIKE '105-EP01b%' --TotalCasesRecorded(Confirmed & Unconfirmed)
           );
---Prove Data Qaulity 
DECLARE @SourceCases INT, @TargetCases INT;

---Grab Count From destination  from staging table

SELECT @SourceCases = SUM(TotalCasesRecorded)
FROM [MalariaLanding_DB].dbo.Stg_Malaria_Permanent;

---Grab Count FROM destination fact table
SELECT @TargetCases = SUM(TotalCases)
FROM [MalariaWareHouse_DB].dbo.Fact_Malaria;

--Log Results to Validation Table.
INSERT INTO DataQualityChecks(BatchID, TargetTable, MetricName, SourceValue, TargetValue, Variance, CheckResult, ActionTaken)
VALUES (
		BatchID, 'Fact_Malaria', 'TotalCases_Reconciliation',
		@SourceCases, @TargetCases, (@SourceCases - @TargetCases),
		CASE WHEN (@SourceCases - @TargetCases) = 0 THEN 
		'PASS' ELSE 'FAIL' END,
		CASE WHEN (@SourceCases - @TargetCases) = 0 THEN
		'LOG_ONLY' ELSE 'HALT_PIPELINE' END
);
          
          
          DECLARE @sql NVARCHAR(MAX);
        SET @sql = '
        WITH Unpivoted AS (
            SELECT
                organisationunitid AS FacilityID,
                orgunitlevel2 AS Region,
                organisationunitname AS District,
                ColName,
                Value
            FROM Malaria2024
            UNPIVOT (
                Value FOR ColName IN (' + @cols + ')
            ) u
        ),
        Parsed AS (
            SELECT 
                FacilityID,
                Region, 
                District,
                CAST(RIGHT(ColName,4) AS INT) AS Year,

                CASE
                    WHEN ColName LIKE ''%January%'' THEN 1
                    WHEN ColName LIKE ''%February%'' THEN 2
                    WHEN ColName LIKE ''%March%'' THEN 3
                    WHEN ColName LIKE ''%April%'' THEN 4
                    WHEN ColName LIKE ''%May%'' THEN 5
                    WHEN ColName LIKE ''%June%'' THEN 6
                    WHEN ColName LIKE ''%July%'' THEN 7
                    WHEN ColName LIKE ''%August%'' THEN 8
                    WHEN ColName LIKE ''%September%'' THEN 9
                    WHEN ColName LIKE ''%October%'' THEN 10
                    WHEN ColName LIKE ''%November%'' THEN 11
                    WHEN ColName LIKE ''%December%'' THEN 12
                END AS Month,
   
                CASE 
                    WHEN ColName LIKE ''105-EP01c%'' THEN ''ConfirmedCases''
                    WHEN ColName LIKE ''105-EP01d%'' THEN ''TreatedCases''
                    WHEN ColName LIKE ''105-MC04%''  THEN ''PregnancyCases''
                    WHEN ColName LIKE ''105-EP01b%'' THEN ''TotalCasesRecorded''
                END AS CaseType,

                CASE
                    WHEN ColName LIKE ''%0-28Dys%'' THEN ''0-28Dys''
                    WHEN ColName LIKE ''%29Dys-4Yrs%'' THEN ''29Days-4yrs''
                    WHEN ColName LIKE ''%5-9Yrs%'' THEN ''5-9yrs''
                    WHEN ColName LIKE ''%10-19Yrs%'' THEN ''10-19yrs''
                    WHEN ColName LIKE ''%20+Yrs%'' THEN ''20+''
                END AS AgeGroup,

                CASE 
                    WHEN ColName LIKE ''%Female%'' THEN ''Female''
                    WHEN ColName LIKE ''% Male%'' THEN ''Male''
                END AS Gender,

                Value
            FROM Unpivoted
        )
        INSERT INTO Stg_Malaria_Permanent(
            FacilityID,
            Region,
            District,
            Year,
            Month,
            AgeGroup,
            Gender,
            ConfirmedCases,
            TreatedCases,
            PregnancyCases,
            TotalCasesRecorded
        )
        SELECT 
             FacilityID,
             Region,
             District,
             Year,
             Month,
             AgeGroup,
             Gender,
             SUM(CASE WHEN CaseType = ''ConfirmedCases'' THEN Value ELSE 0 END) AS ConfirmedCases,
             SUM(CASE WHEN CaseType = ''TreatedCases'' THEN Value ELSE 0 END) AS TreatedCases,
             SUM(CASE WHEN CaseType = ''PregnancyCases'' THEN Value ELSE 0 END) AS PregnancyCases,
             SUM(CASE WHEN CaseType = ''TotalCasesRecorded'' THEN Value ELSE 0 END) AS TotalCasesRecorded
        FROM Parsed
        GROUP BY 
               FacilityID,
               Region,
               District,
               Year, 
               Month,
               AgeGroup,
               Gender
        '

EXEC sp_executesql @sql
;
GO















