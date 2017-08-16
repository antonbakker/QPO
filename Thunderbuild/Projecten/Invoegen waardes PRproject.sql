DECLARE @name VARCHAR(50) -- database name 
  
DECLARE db_cursor CURSOR FOR 
SELECT name
FROM master.dbo.sysdatabases
WHERE name IN ('512', '513', '514', '521', '522', '523', '524', '525', '527', '528', '541', '542', '543', '544', '561', '571', '581', '582', '583', '591', '593', '594')  -- include these databases
/*WHERE name IN ('421')*/
 
 
OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @name  
 
WHILE @@FETCH_STATUS = 0  
BEGIN

DECLARE @query VARCHAR(MAX)


/* Projecten */
SET @query =
'
INSERT INTO [DWH].[dbo].[qProjectPRExact]
(
ProjectNr,
Projectomschrijving,
Division,
ProjectStatus,
ProjectMemo,
Aanneemsom,
NumberField2,
POCbedrag,
NumberField4,
NumberField5,
Projectleider,
Uitvoerder,
Calculator,
TextField4,
Kernactiviteit,
-- Relatiecode,
-- Relatienaam,
-- Straatnaam,
-- Postcode,
-- Plaatsnaam,
-- Landcode	
)
	
	
SELECT
pro.ProjectNr AS ProjectNr,
pro.Description AS Projectomschrijving,
pro.Division AS Division,
pro.Status AS ProjectStatus,
pro.Memo AS ProjectMemo,
pro.NumberField1 AS Aanneemsom,
pro.NumberField2 AS NumberField2,
pro.NumberField3 AS POCbedrag,
pro.NumberField4 AS NumberField4,
pro.NumberField5 AS NumberField5,
pro.TextField1 AS Projectleider,
pro.TextField2 AS Uitvoerder,
pro.TextField3 AS Calculator,
pro.TextField4 AS TextField4,
pro.TextField5 AS Kernactiviteit,
-- Rel.[cmp_code] AS Relatiecode,
-- Rel.[cmp_name] AS Relatienaam,
-- Rel.[cmp_fadd1] AS Straatnaam,
-- Rel.[cmp_fpc] AS Postcode,
-- Rel.[cmp_fcity] AS Plaatsnaam,
-- Rel.[cmp_fctry] AS Landcode
FROM
[' + @name + '].[dbo].[PRProject] AS pro
-- LEFT JOIN [' + @name + '].[dbo].cicmpy AS Rel
-- ON pro.[IDCustomer] = Rel.[cmp_wwn]
'

EXEC( @query)

 
  FETCH NEXT FROM db_cursor INTO @name  
END  
 
CLOSE db_cursor  
DEALLOCATE db_cursor