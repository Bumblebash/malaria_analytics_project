USE MalariaAudit;


DECLARE @BatchID UNIQUEIDENTIFIER = NEWID();
DECLARE @RowsRead INT, @RowsWritten INT;
DECLARE @SourceCases INT, @TargetCases INT;

--Initialize Operational Logging:
INSERT INTO pipelinelogs(BatchID, PipelineName, TaskName, Status)
VALUES (@BatchID, 'Malaria_ETL', 'Fact_Malaria_Load', 'STARTED');


BEGIN TRY
		BEGIN TRANSACTION;
/**Count incoming Source Volume**/
		SELECT @RowsRead = COUNT(*), @SourceCases = ISNULL(SUM(TotalCasesRecorded),0)
		FROM [MalariaLanding_DB].dbo.Stg_Malaria_Permanent;



		-- 2. INSERT TRANSACTION LOGIC
		INSERT INTO [MalariaWareHouse_DB].dbo.Fact_Malaria(RegionKey,DistrictKey, DateKey, GenderKey, AgeKey, ConfirmedCases, TreatedCases, PregnantCases, TotalCases)
SELECT
       dist.RegionKey,
       dist. DistrictKey,
       d.DateKey,
       gen.GenderKey,
       age.AgeKey,
       m.ConfirmedCases,
       m.TreatedCases,
       m.PregnancyCases,
       m.TotalCasesRecorded As TotalCases
FROM [MalariaLanding_DB].dbo.Stg_Malaria_Permanent m
JOIN [MalariaWareHouse_DB].dbo.DimDate d ON m.Year = d.Year AND d.Month = m.Month
--JOIN Dimpopulation p ON m.District = p.DistrictName
JOIN [MalariaWareHouse_DB].dbo.DimDistrict dist ON m.District = dist.DistrictName
JOIN [MalariaWareHouse_DB].dbo.DimAgeGroup age ON m.AgeGroup = age.AgeGroup
JOIN [MalariaWareHouse_DB].dbo.DimGender gen ON m.Gender = gen.Gender
;
SET @Rowswritten = @@ROWCOUNT;

COMMIT TRANSACTION;



--3. Calculate Target Reconciliation Metrics After Commit
	SELECT @TargetCases = SUM(TotalCases)
	FROM [MalariaWareHouse_DB].dbo.Fact_Malaria;

--4 LOG Comprehensive DQ Metrics

INSERT INTO DataQualityChecks(BatchID, TargetTable, MetricName, SourceValue, TargetValue, Variance, CheckResult, ActionTaken)
		VALUES (@BatchID, 'Fact_Malaria', 'CaseCount_Reconciliation', @SourceCases, ISNULL(@TargetCases, 0), (@SourceCases - ISNULL(@TargetCases, 0)),
		CASE WHEN (@SourceCases - @TargetCases) = 0
		THEN 'PASS' ELSE 'FAIL' END, 'LOG_ONLY');


--Update Operational Log Entry to success
UPDATE pipelinelogs
SET EndTime = GETDATE(), RowsRead = @RowsRead,
Rowswritten = @Rowswritten, STATUS = 'SUCCESS'
WHERE BATCHID = @BatchID AND TaskName = 'Fact_Malaria_Load';

END TRY
BEGIN CATCH
---ROLL BACK ALL Adjustment if a crash occurs

IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
--LOG EXPLICIT SYSTEM FAILURE DATA FOR DEBUGGING 
UPDATE pipelinelogs
       SET EndTime = GETDATE(), STATUS = 'FAILED',
ErrorMessage = ERROR_MESSAGE()
WHERE BATCHID = @BatchID AND TaskName = 'Fact_Malaria_Load';

THROW; --Escalate error Notification
END CATCH;


SELECT * FROM pipelinelogs;
SELECT * FROM DataQualityChecks;


USE MalariaWareHouse_DB;
TRUNCATE TABLE Fact_Malaria;


USE MalariaWareHouse_DB;

SELECT * FROM Fact_Malaria;