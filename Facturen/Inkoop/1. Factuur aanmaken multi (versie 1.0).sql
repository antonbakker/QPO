set transaction isolation level read uncommitted
--KOPregel INKOOP
-- START -- lijst met betrokken administraties
create table #divisions	(	id int identity (1,1),
							division varchar(50)
						)
						
insert into #divisions 
select 	'512' 
union all
select 	'521' 
union all
select 	'522'
union all
select 	'523'
union all
select 	'524'
union all
select 	'525'
union all
select 	'527' 
union all
select 	'528'
union all
select 	'541'
union all
select 	'542' 
union all
select 	'543'
union all
select 	'547'
union all
select 	'561'
-- union all
-- select 	'961'


-- EINDE -- lijst met betrokken administraties


---- START -- opbouwen tabel met reeds geboekte doorbelastingen
create table #check	(	
						--targetDivision varchar(50),
						freefield1 varchar(75)
					)

declare @counter_current int = 1
declare @division_current varchar(50)
declare @query nvarchar(max)
while @counter_current <= ( select MAX(id) from #divisions )
	begin
		set @division_current = ( select top 1 division from #divisions where id = @counter_current )
		set @query =	'
							select distinct Isnull(freefield1,1) from   [' + @division_current  + ']..gbkmut WITH(NOLOCK) where dagbknr= '' 40''
						'
						
		insert into #check
		exec sp_executesql @query,N'@division_current varchar(50)
                               ',
                                @division_current = @division_current

		
		set @counter_current = @counter_current + 1
	
	end 

---- EINDE -- opbouwen tabel met reeds geboekte doorbelastingen




-- START -- opbouwen tabel met kopregel gegevens
create table #result	(	id int identity(1,1),
							faktuurnr varchar(60),
							k_kopdatum datetime,
							betreft varchar(60),						
							crediteur varchar(50),
							yourRef varchar(50),
							targetDivision varchar(50)
						)
							

set @counter_current = 1
set @division_current = ''
set @query = ''
while @counter_current <= ( select MAX(id) from #divisions )
	begin 
		set @division_current = ( select top 1 division from #divisions where id = @counter_current )
		
		set @query =	'	SELECT                       g.faktuurnr
		
		 , g.datum AS k_kopdatum
		 , max(g.docnumber) AS betreft,
		crediteur = ''999''+right(left(ltrim(g.freefield1),3),2) 
	 , yourref = CONVERT(VARCHAR(50), @division_current) 
                 + ''-'' + CONVERT(VARCHAR(50), g.bkstnr)
	,targetDivision	= right(rtrim(g.debnr),2)	
FROM        [' + @division_current  + ']..gbkmut AS g INNER JOIN  [' + @division_current  + ']..grtbk ON g.reknr = grtbk.reknr 
					
						 
WHERE  1 = 1 
       AND transtype NOT IN( ''V'', ''B'' ) AND ( transsubtype <> ''X'' ) 
       AND g.freefield1 is not null 
	   and g.dagbknr = '' 60''
	   and g.reknr <> ''     1300'' --alleen omzet rek
     and 
    CONVERT(VARCHAR(50), @division_current) 
                 + ''-'' + CONVERT(VARCHAR(50), g.bkstnr) not in (select freefield1 collate database_default from #check)
GROUP BY g.faktuurnr, g.datum,g.freefield1,g.bkstnr,g.debnr	'
			
		insert into #result
		exec sp_executesql @query,N'@division_current varchar(50)
                               ',
                                @division_current = @division_current

		set @counter_current = @counter_current + 1
	end 
		




--select * from #check -- tbv test
select distinct
faktuurnr,	targetDivision,	k_kopdatum,	betreft,	crediteur,	yourref
 
from #result -- tbv test 
--select * from #divisions -- tbv test	
-- EINDE -- opbouwen tabel met kopregel gegevens
drop table #check
drop table #result
drop table #divisions