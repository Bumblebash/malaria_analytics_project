USE MLanding1;


GO 

ALTER  PROCEDURE  dbo.SP_Execute_National_Malaria_ETL
    @SourceTableName NVARCHAR(100), -- Dynamic file reference input parameter
    @ReportingYear INT
AS
BEGIN
    SET NOCOUNT ON;

    -- 1. INITIALIZE MASTER BATCH LINEAGE PARAMETERS
    DECLARE @BatchID UNIQUEIDENTIFIER = NEWID();
    DECLARE @RowsRead INT = 0, @RowsWritten INT = 0;
    DECLARE @SumSourceCases BIGINT = 0, @SumTargetCases BIGINT = 0;
    DECLARE @DynamicSQL NVARCHAR(MAX) = '';
    DECLARE @ColumnList NVARCHAR(MAX) = '';

    INSERT INTO [MLanding1].dbo.PipelineExecutionLogs (BatchID, TaskName, TargetTable, Status, StartTime)
    VALUES (@BatchID, 'Master_E2E_Malaria_Ingestion', 'Multiple', 'STARTED', GETDATE());

    BEGIN TRY
        BEGIN TRANSACTION;

        -- 2. DYNAMICALLY PARSE VARYING 480+ SOURCE COLUMNS FROM THE LANDING MATRIX
        SELECT @ColumnList = STRING_AGG(CAST(QUOTENAME(COLUMN_NAME) AS NVARCHAR(MAX)), ',')
        FROM MLanding1.INFORMATION_SCHEMA.COLUMNS
        WHERE TABLE_NAME = @SourceTableName
          AND (COLUMN_NAME LIKE '105-EP01c%' 
               OR COLUMN_NAME LIKE '105-EP01d%' 
               OR COLUMN_NAME LIKE '105-MC04%'  
               OR COLUMN_NAME LIKE '105-EP01b%');

        -- 3. EXECUTE UNPIVOT TRANSFORMATION WITH ON-THE-FLY ROW VALIDATION
        SET @DynamicSQL = '
            WITH RawUnpivoted AS (
                SELECT
                    organisationunitid AS FacilityID,
                    UPPER(orgunitlevel2) AS Region,
                    UPPER(organisationunitname) AS District,
                    ColName,
                    TRY_CAST(Value AS INT) AS MetricValue
                FROM [MLanding1].dbo.' + QUOTENAME(@SourceTableName) + '
                UNPIVOT (Value FOR ColName IN (' + @ColumnList + ')) u
            ),
            ParsedPayload AS (
                SELECT 
                    FacilityID, Region, District, MetricValue,
                    ' + CAST(@ReportingYear AS VARCHAR(4)) + ' AS Year,
                    CASE
                        WHEN UPPER(ColName) LIKE ''%JANUARY%''   THEN 1
                        WHEN UPPER(ColName) LIKE ''%FEBRUARY%''  THEN 2
                        WHEN UPPER(ColName) LIKE ''%MARCH%''     THEN 3
                        WHEN UPPER(ColName) LIKE ''%APRIL%''     THEN 4
                        WHEN UPPER(ColName) LIKE ''%MAY%''       THEN 5
                        WHEN UPPER(ColName) LIKE ''%JUNE%''      THEN 6
                        WHEN UPPER(ColName) LIKE ''%JULY%''      THEN 7
                        WHEN UPPER(ColName) LIKE ''%AUGUST%''    THEN 8
                        WHEN UPPER(ColName) LIKE ''%SEPTEMBER%'' THEN 9
                        WHEN UPPER(ColName) LIKE ''%OCTOBER%''   THEN 10
                        WHEN UPPER(ColName) LIKE ''%NOVEMBER%''  THEN 11
                        WHEN UPPER(ColName) LIKE ''%DECEMBER%''  THEN 12
                    END AS Month,
                    CASE 
                        WHEN ColName LIKE ''105-EP01c%'' THEN ''ConfirmedCases''
                        WHEN ColName LIKE ''105-EP01d%'' THEN ''TreatedCases''
                        WHEN ColName LIKE ''105-MC04%''  THEN ''PregnancyCases''
                        WHEN ColName LIKE ''105-EP01b%'' THEN ''TotalCasesRecorded''
                    END AS CaseType,
                    CASE
                        WHEN UPPER(ColName) LIKE ''%0-28DYS%''    THEN ''0-28Dys''
                        WHEN UPPER(ColName) LIKE ''%29DYS-4YRS%'' THEN ''29Days-4yrs''
                        WHEN UPPER(ColName) LIKE ''%5-9YRS%''     THEN ''5-9yrs''
                        WHEN UPPER(ColName) LIKE ''%10-19YRS%''   THEN ''10-19yrs''
                        WHEN UPPER(ColName) LIKE ''%20+YRS%''     THEN ''20+''
                    END AS AgeGroup,
                    CASE 
                        WHEN UPPER(ColName) LIKE ''%FEMALE%'' THEN ''Female''
                        WHEN UPPER(ColName) LIKE ''%MALE%''   THEN ''Male''
                    END AS Gender
                FROM RawUnpivoted
            )
            INSERT INTO [MLanding1].dbo.Stg_Malaria_Permanent (
                BatchID, FacilityID, Region, District, Year, Month, AgeGroup, Gender, 
                ConfirmedCases, TreatedCases, PregnancyCases, TotalCasesRecorded, DataQualityFlag
            )
            SELECT 
                 ''' + CAST(@BatchID AS VARCHAR(50)) + ''', FacilityID, Region, District, Year, Month, AgeGroup, Gender,
                 SUM(CASE WHEN CaseType = ''ConfirmedCases'' THEN MetricValue ELSE 0 END),
                 SUM(CASE WHEN CaseType = ''TreatedCases'' THEN MetricValue ELSE 0 END),
                 SUM(CASE WHEN CaseType = ''PregnancyCases'' THEN MetricValue ELSE 0 END),
                 SUM(CASE WHEN CaseType = ''TotalCasesRecorded'' THEN MetricValue ELSE 0 END),
                 CASE 
                    WHEN SUM(CASE WHEN CaseType = ''TotalCasesRecorded'' THEN MetricValue ELSE 0 END) < 0 THEN ''REJECT: Negative Outlier''
                    WHEN District IS NULL THEN ''QUARANTINE: Orphaned Location''
                    ELSE ''PASSED''
                 END
            FROM ParsedPayload
            GROUP BY FacilityID, Region, District, Month, AgeGroup, Gender, Year;';

        EXEC sp_executesql @DynamicSQL;

        -- 4. REFRESH AUXILIARY STRUCTURAL DIMENSIONS ON THE FLY
        INSERT INTO DimRegion (Region)
        SELECT DISTINCT Region FROM [MLanding1].dbo.Stg_Malaria_Permanent 
        WHERE BatchID = @BatchID AND Region NOT IN (SELECT Region FROM DimRegion);

        INSERT INTO DimGender (Gender)
        SELECT DISTINCT Gender FROM [MLanding1].dbo.Stg_Malaria_Permanent 
        WHERE BatchID = @BatchID AND Gender NOT IN (SELECT Gender FROM DimGender);

        INSERT INTO [MLanding1].dbo.DimAgeGroup (AgeGroup)
        SELECT DISTINCT AgeGroup
        FROM [MLanding1].dbo.Stg_Malaria_Permanent 
        WHERE BatchID = @BatchID AND AgeGroup NOT IN (SELECT AgeGroup FROM DimAgeGroup);

        -- 5. SYNCHRONIZE SCD TYPE 2 MASTER REGIONAL DISTRICT BOUNDARIES
        UPDATE target
        SET target.IsCurrent = 0, target.ValidTo = GETDATE()
        FROM [MLanding1].dbo.DimDistrict target
        INNER JOIN [MLanding1].dbo.Stg_Malaria_Permanent src ON src.District = target.DistrictName
        INNER JOIN DimRegion r ON r.Region = src.Region
        WHERE src.BatchID = @BatchID AND target.IsCurrent = 1 AND target.RegionKey <> r.RegionKey;

        INSERT INTO [MLanding1].dbo.DimDistrict (DistrictName, RegionKey, IsCity, ValidFrom, ValidTo, IsCurrent)
        SELECT DISTINCT src.District, r.RegionKey, CASE WHEN src.District LIKE '%CITY%' THEN 1 ELSE 0 END, GETDATE(), NULL, 1
        FROM [MLanding1].dbo.Stg_Malaria_Permanent src
        INNER JOIN DimRegion r ON r.Region = src.Region
        WHERE src.BatchID = @BatchID 
          AND src.District NOT IN (SELECT DistrictName FROM DimDistrict WHERE IsCurrent = 1);

        -- 6. TRANSFER TRANSACTIONAL VALUES FROM SILVER TO GOLD LAYER FACT TABLES
        INSERT INTO [MLanding1].dbo.Fact_Malaria(BatchID, RegionKey, DistrictKey, DateKey, GenderKey, AgeKey, ConfirmedCases, TreatedCases, PregnantCases, TotalCases)
        SELECT 
            @BatchID, 
            r.RegionKey, 
            dist.DistrictKey, 
            d.DateKey, -- FIXED: Was incorrectly mapped to d.Year before
            gen.GenderKey, 
            age.AgeKey,
            stg.ConfirmedCases, 
            stg.TreatedCases, 
            stg.PregnancyCases, 
            stg.TotalCasesRecorded
        FROM [MLanding1].dbo.Stg_Malaria_Permanent stg
        INNER JOIN [MLanding1].dbo.DimRegion r ON r.Region = stg.Region
        INNER JOIN [Mlanding1].dbo.DimDistrict dist ON dist.DistrictName = stg.District AND dist.IsCurrent = 1
        INNER JOIN [MLanding1].dbo.DimDate d ON d.Year = stg.Year AND d.Month = stg.Month
        INNER JOIN DimAgeGroup age ON age.AgeGroup = stg.AgeGroup
        INNER JOIN DimGender gen ON gen.Gender = stg.Gender
        WHERE stg.BatchID = @BatchID AND stg.DataQualityFlag = 'PASSED';

        SET @RowsWritten = @@ROWCOUNT;

        -- 7. EXECUTE DATA QUALITY BALANCING GATEKEEPER CHECK
        SELECT @SumSourceCases = ISNULL(SUM(TotalCasesRecorded), 0) 
        FROM [MLanding1].dbo.Stg_Malaria_Permanent WHERE BatchID = @BatchID AND DataQualityFlag = 'PASSED';

        SELECT @SumTargetCases = ISNULL(SUM(TotalCases), 0) 
        FROM [MLanding1].dbo.Fact_Malaria WHERE BatchID = @BatchID;

        INSERT INTO [MLanding1].dbo.DataQualityCheckLogs(BatchID, TargetTable, MetricName, SourceValue, TargetValue, Variance, CheckResult, ActionTaken)
        VALUES (ELSE 'FORCE_ROLLBACK' END
        );
            @BatchID, 'Fact_Malaria', 'TotalCases_Run_Reconciliation', @SumSourceCases, @SumTargetCases, (@SumSourceCases - @SumTargetCases),
            CASE WHEN (@SumSourceCases - @SumTargetCases) = 0 THEN 'PASS' ELSE 'FAIL' END,
            CASE WHEN (@SumSourceCases - @SumTargetCases) = 0 THEN 'COMMIT_LOAD' 

        -- 8. CONDITIONAL TRANSACTION RESOLUTION BOUNDARY
        IF (@SumSourceCases - @SumTargetCases) = 0
        BEGIN
            COMMIT TRANSACTION;
            
            UPDATE [Mlanding1].dbo.PipelineExecutionLogs
            SET EndTime = GETDATE(), Status = 'SUCCESS', RowsRead = @RowsRead, RowsWritten = @RowsWritten
            WHERE BatchID = @BatchID;
        END
        ELSE
        BEGIN
            RAISERROR('Critical Validation Error: Target fact metric totals vary from unpivoted source baselines.', 16, 1);
        END

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;

        UPDATE [MLanding1].dbo.PipelineExecutionLogs
        SET EndTime = GETDATE(), Status = 'FAILED', ErrorMessage = ERROR_MESSAGE()
        WHERE BatchID = @BatchID;
        THROW;
    END CATCH
END;
GO
