USE MalariaAudit;

---LOG TABLE

CREATE TABLE pipelinelogs(
			LogID BIGINT IDENTITY(1,1) PRIMARY KEY,
			BATCHID UNIQUEIDENTIFIER NOT NULL,
			PipelineName VARCHAR(100) NOT NULL,
			TaskName VARCHAR(100) NOT NULL,
			StartName DATETIME DEFAULT GETDATE(),
			EndTime DATETIME NULL,
			RowsRead INT NULL,
			RowsWritten INT NULL,
			RowsRejected INT NULL,
			[Status] VARCHAR(20) NOT NULL,
			ErrorMessage NVARCHAR(MAX) NULL
			);




----VALIDATION TABLE/DataQaulity Checks
CREATE TABLE DataQualityChecks(
				CheckID BIGINT IDENTITY(1,1) PRIMARY KEY,
				BatchID UNIQUEIDENTIFIER NOT NULL,
				CheckTimestamp DATETIME DEFAULT GETDATE(),
				TargetTable VARCHAR(100) NOT NULL,
				MetricName VARCHAR(100) NOT NULL,
				SourceValue NUMERIC(18,2) NOT NULL,
				TargetValue NUMERIC(18,2) NOT NULL,
				Variance NUMERIC(18,2) NOT NULL,
				CheckResult VARCHAR(10) NOT NULL,
				ActionTaken VARCHAR(50) NOT NULL

);



DECLARE @BatchID UNIQUEIDENTIFIER = NEWID();

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
		@BatchID, 'Fact_Malaria', 'TotalCases_Reconciliation',
		@SourceCases, @TargetCases, (@SourceCases - @TargetCases),
		CASE WHEN (@SourceCases - @TargetCases) = 0 THEN 
		'PASS' ELSE 'FAIL' END,
		CASE WHEN (@SourceCases - @TargetCases) = 0 THEN
		'LOG_ONLY' ELSE 'HALT_PIPELINE' END
);

SELECT * FROM DataQualityChecks;



---Check for unwrappedd BusnessEntities
SELECT COUNT(*)
 FROM [MalariaLanding_DB].dbo.Stg_Malaria_Permanent m
 LEFT JOIN [MalariaWareHouse_DB].dbo.DimDistrict d ON m.District = d.DistrictName
 WHERE d.DistrictKey IS NULL;
