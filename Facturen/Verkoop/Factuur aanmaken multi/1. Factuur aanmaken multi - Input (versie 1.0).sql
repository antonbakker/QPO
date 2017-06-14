set transaction isolation level read uncommitted
--KOPregel multi
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

-- EINDE -- lijst met betrokken administraties


-- START -- opbouwen tabel met reeds geboekte doorbelastingen
create table #check
	(
		id int identity (1,1),
		targetDivision varchar(50),				
		freefield1 varchar(75)
	)

declare @counter_current int = 1
declare @division_current varchar(50)
declare @query nvarchar(max)
while @counter_current <= ( select MAX(id) from #divisions )
	begin
		set @division_current = ( select top 1 division from #divisions where id = @counter_current )
		set @query =							
			'
				SELECT distinct	
					@division_current, 
					isnull(frsrg.ordernr, ''1'')
				FROM   [' + @division_current  + ']..frsrg 

				UNION ALL
		
				SELECT distinct	
					@division_current,
					isnull(frhsrg.ordernr, ''1'')
				FROM   [' + @division_current  + ']..frhsrg 
			'				
		insert into #check
		exec sp_executesql @query,N'@division_current varchar(50)', @division_current = @division_current
		set @counter_current = @counter_current + 1
	end 
	
	--select * from #check
-- EINDE -- opbouwen tabel met reeds geboekte factuurregels




-- START -- opbouwen tabel met kopregel gegevens
create table #result
	(
		id int identity(1,1),
		--description varchar(60),
		--Kdatum datetime,
		--Kdocdate datetime,
		targetDivision varchar(50),
		debnr varchar(50),
		uwref varchar(50),
		oms varchar(50),
		periode varchar (50),
		--input varchar(50)
	)
							

set @counter_current = 1
set @division_current = ''
set @query = ''
while @counter_current <= ( select MAX(id) from #divisions )
	begin 
		set @division_current = ( select top 1 division from #divisions where id = @counter_current )
		
		set @query =
			'
				select distinct
					@division_current,
					''399''+ LEFT (kstdrcode,2) debnr,
					g.kstdrcode uwref,
					g.project,
					year(docdate)*100+DATEPART (week,docdate)  periode
				from
					[' + @division_current  + ']..gbkmut g
				where
					g.dagbknr= '' 98'' 
					AND transtype not in( ''V'',''B'')
					AND (transsubtype <> ''X'')
					AND kstdrcode is not null
					AND project is not null
					AND ( g.id ) Not IN (SELECT freefield1 FROM   #CHECK)  
			'
			
		insert into #result
		exec sp_executesql @query,N'@division_current varchar(50)
                               ',
                                @division_current = @division_current

		set @counter_current = @counter_current + 1
	end 
		




--select * from #check -- tbv test
select distinct targetDivision, debnr,'Week '+ MAX( Periode) uwref, 
targetDivision+'-'+debnr+'-'+periode as groepering,
'Week '+ MAX( Periode) oms

from #result


Group by targetDivision+'-'+debnr+'-'+periode, targetDivision, debnr 
-- order by input-- tbv test 
--select * from #divisions -- tbv test	
-- EINDE -- opbouwen tabel met kopregel gegevens
drop table #check
drop table #result
drop table #divisions