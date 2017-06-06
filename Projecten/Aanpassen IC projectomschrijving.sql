DECLARE @name VARCHAR(50) -- database name

DECLARE db_cursor CURSOR FOR
SELECT name
FROM master.dbo.sysdatabases
/*WHERE name IN ('512', '513', '514', '521', '522', '523', '524', '525', '527', '528', '541', '542', '543', '544', '561', '571', '581', '582', '583', '591', '593', '594') */ -- include these databases
WHERE name IN ('961')


OPEN db_cursor
FETCH NEXT FROM db_cursor INTO @name

WHILE @@FETCH_STATUS = 0
BEGIN

DECLARE @query VARCHAR(MAX)

SET @query =
'
  UPDATE [' + @name + '].[dbo].[PRProject]
   SET Description =
    (
    SELECT
      ''Intercompany project'' + '' '' + Opdrachtgever + '' 20'' + Jaar + ''-W'' + Week
    FROM
      (
        SELECT
          RIGHT(LEFT(ProjectNr, LEN(ProjectNr)), 2) AS Week,
          CASE RIGHT(LEFT(ProjectNr, LEN(ProjectNr)-2), 2)
            WHEN 12 THEN ''SHZ''
            WHEN 21 THEN ''SAZ''
            WHEN 22 THEN ''SZVL''
            WHEN 23 THEN ''SMA''
            WHEN 24 THEN ''KRY''
            WHEN 25 THEN ''ZCM''
            WHEN 27 THEN ''DBX''
            WHEN 28 THEN ''BIS''
            WHEN 41 THEN ''INN''
            WHEN 42 THEN ''GSZ''
            WHEN 43 THEN ''CSI''
            WHEN 47 THEN ''ZGR''
            WHEN 61 THEN ''KOL''
            ELSE ''ERROR''
          END AS Opdrachtgever,
          RIGHT(LEFT(ProjectNr, LEN(ProjectNr)-4), 2) AS Jaar,
          RIGHT(LEFT(ProjectNr, LEN(ProjectNr)-6), 2) AS Opdrachtnemer,
	        ProjectNr AS ProjectNr
        FROM
          [' + @name + '].[dbo].[PRProject]
        WHERE LEN(ProjectNr) = 10
        and ProjectNr like ''99%''
      ) AS ICP
	  WHERE ProjectNr = ICP.ProjectNr
    )
  WHERE ProjectNr = Description
'

EXEC( @query)

  FETCH NEXT FROM db_cursor INTO @name
END

CLOSE db_cursor
DEALLOCATE db_cursor
