--Subregels
set transaction isolation level read uncommitted

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
union all
select 	'961'
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
							select distinct Isnull(freefield1,1) from   [' + @division_current  + ']..gbkmut WITH(NOLOCK) where dagbknr= '' 50''
						'
						
		insert into #check
		exec sp_executesql @query,N'@division_current varchar(50)
                               ',
                                @division_current = @division_current

		
		set @counter_current = @counter_current + 1
	
	end 

-- EINDE -- opbouwen tabel met reeds geboekte doorbelastingen




-- START -- opbouwen tabel met SUBregel gegevens
create table #result	(	id int identity(1,1),
							description varchar(60),
							datum datetime,
							docdate datetime,
							
							crediteur varchar(50),
							yourRef varchar(50),
							faktuurnr  varchar(50), 
   							bedrag varchar(50), 
							oms25 varchar(80), 
							r_reknr varchar(50), 
							kstdrcode varchar(50),
							BTWcode varchar(50),
							freefield1 varchar(50),
								targetDivision varchar(50)
						)
							

set @counter_current = 1
set @division_current = ''
set @query = ''
while @counter_current <= ( select MAX(id) from #divisions )
	begin 
		set @division_current = ( select top 1 division from #divisions where id = @counter_current )
		
		set @query =	'	SELECT description = docnumber, 
       datum = datum, 
       docdate = docdate, 
      
       crediteur = ''999''+right(left(ltrim(g.freefield1),3),2) ,
       yourref = CONVERT(VARCHAR(50), @division_current) 
                 + ''-'' + CONVERT(VARCHAR(50), g.bkstnr), 
       faktuurnr, 
      SUM( bdr_hfl) *-1      bedrag, 
       oms25, 
       ''1936''       r_reknr, 
       g.kstdrcode,
   case when  g.btw_code = ''13    '' then ''9'' else ''5'' end BTWcode,
       g.freefield1
       
      ,targetDivision	= right(rtrim(g.debnr),2)	
     
FROM        [' + @division_current  + ']..gbkmut AS g INNER JOIN  [' + @division_current  + ']..grtbk ON g.reknr = grtbk.reknr 
 
WHERE  1 = 1 
       AND transtype NOT IN( ''V'', ''B'' ) AND ( transsubtype <> ''X'' ) 
       AND g.freefield1 is not null 
	   and g.dagbknr = '' 60''
	   and g.reknr <> ''     1300'' --alleen omzet rek
	   and  CONVERT(VARCHAR(50), @division_current) + ''-'' + CONVERT(VARCHAR(50), g.bkstnr)
	    NOT in (select freefield1 collate database_default from #check)
	   GROUP BY g.docnumber, g.datum, g.docdate, g.bkstnr, g.debnr,
                       g.faktuurnr,  g.oms25, g.kstdrcode, g.freefield1,  g.reknr,case when  g.btw_code = ''13    '' then ''9'' else ''5'' end
						'
			
		insert into #result
		exec sp_executesql @query,N'@division_current varchar(50)
                               ',
                                @division_current = @division_current

		set @counter_current = @counter_current + 1
	end 
		

--select * from #check -- tbv test
select 					id ,
							description
						,	datum,	docdate,	crediteur,
								yourref	,faktuurnr,	bedrag
						,	oms25,	r_reknr
						,	kstdrcode
						,	BTWcode,	freefield1
,targetDivision
from #result -- tbv test
--select * from #divisions -- tbv test	
-- EINDE -- opbouwen tabel met kopregel gegevens
drop table #check
drop table #result
drop table #divisions