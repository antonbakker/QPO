-- kopregel inkoopfactuur
set transaction isolation level read uncommitted
DECLARE @division_current VARCHAR(50)

SET @division_current = '961'

DECLARE @FreeField1 TABLE(Nummer varchar(60))
INSERT INTO	@FreeField1
select distinct Isnull(freefield1,1) from [541]..gbkmut WITH(NOLOCK) where dagbknr= ' 50'


SELECT
	g.faktuurnr,
	right(rtrim(g.debnr),2) doeladm
	 , g.datum AS k_kopdatum
		 , max(g.docnumber) AS betreft,
		crediteur = '999'+right(left(ltrim(g.freefield1),3),2)
		 , yourref = CONVERT(VARCHAR(50), @division_current)
                 + '-' + CONVERT(VARCHAR(50), g.bkstnr)

FROM         [961]..gbkmut AS g INNER JOIN  [961]..grtbk ON g.reknr = grtbk.reknr


WHERE  1 = 1
       AND transtype NOT IN( 'V', 'B' ) AND ( transsubtype <> 'X' )
       AND g.freefield1 is not null
	   and g.dagbknr = ' 60'
	   and g.reknr <> '     1300' --alleen omzet rek
      and
      CONVERT(VARCHAR(50), @division_current) + '-' + CONVERT(VARCHAR(50), g.bkstnr) not in (select Nummer collate database_default from @FreeField1)
GROUP BY g.faktuurnr, g.datum,g.freefield1,g.bkstnr, g.debnr

ORDER BY g.faktuurnr
