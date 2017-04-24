set transaction isolation level read uncommitted
--KOPregel multi
-- START -- lijst met betrokken administraties
create table #divisions	(	id int identity (1,1),
							division varchar(50)
						)

insert into #divisions
select 	'521'
union all
select 	'524'
union all
select 	'512'
union all
select 	'528'
union all
select 	'527'
union all
select 	'561'
-- EINDE -- lijst met betrokken administraties


-- START -- opbouwen tabel met reeds geboekte doorbelastingen
create table #check	(	id int identity (1,1),
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
					isnull(frkrg.freefield1, ''x'')

FROM   [' + @division_current  + ']..frkrg


		UNION ALL

						SELECT distinct

					 @division_current,
					isnull(frhkrg.freefield1, ''x'')


FROM   [' + @division_current  + ']..frhkrg



						'


		insert into #check
		exec sp_executesql @query,N'@division_current varchar(50)
                               ',
                                @division_current = @division_current


		set @counter_current = @counter_current + 1

	end

	--select * from #check
-- EINDE -- opbouwen tabel met reeds geboekte factuurregels




-- START -- opbouwen tabel met kopregel gegevens
create table #result	(	id int identity(1,1),
							--description varchar(60),
							--Kdatum datetime,
							--Kdocdate datetime,
							targetDivision varchar(50),
							debnr varchar(50),
							uwref varchar(50),
							periode varchar (50),
							--input varchar(50)

						)


set @counter_current = 1
set @division_current = ''
set @query = ''
while @counter_current <= ( select MAX(id) from #divisions )
	begin
		set @division_current = ( select top 1 division from #divisions where id = @counter_current )

		set @query =	'	select distinct
		@division_current,
							''399''+ LEFT (kstdrcode,2) debnr,
						g.kstdrcode uwref,
						year(docdate)*100+DATEPART (week,docdate)  periode
from [' + @division_current  + ']..gbkmut g
where g.dagbknr= '' 98'' And transtype not in( ''V'',''B'') AND (transsubtype <> ''X'') and kstdrcode is not null and project is not null
--AND ( @division_current+''-''+debnr+''-''+rtrim(g.kstdrcode)+''-'' ) Not IN (SELECT oms45 FROM   #CHECK)
						'

		insert into #result
		exec sp_executesql @query,N'@division_current varchar(50)
                               ',
                                @division_current = @division_current

		set @counter_current = @counter_current + 1
	end





--select * from #check -- tbv test
select distinct targetDivision, debnr,uwref,
targetDivision+'-'+debnr+'-'+rtrim(uwref)+'-'+periode as groepering


from #result
where  targetDivision+'-'+debnr+'-'+rtrim(uwref)+'-'+periode Not IN (SELECT freefield1 FROM   #CHECK)
-- order by input-- tbv test
--select * from #divisions -- tbv test
-- EINDE -- opbouwen tabel met kopregel gegevens
drop table #check
drop table #result
drop table #divisions
