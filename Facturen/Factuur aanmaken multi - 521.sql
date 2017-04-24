set transaction isolation level read uncommitted
--SUBregels
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

						freefield1 varchar(50)

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




-- START -- opbouwen tabel met subregel gegevens
create table #result	(	id int identity(1,1),
						bkstnr varchar(50),
docdate datetime,
datum datetime,
itemcode varchar(50),
btwcode varchar(4),
omschrijving varchar(60),
aantal float,
debnr varchar(50),
reknr varchar(50),
prijs float,
bedrag float,
kstdrcode varchar(50),
projectcode varchar(50),
uwref varchar(50),
res_id int,
targetDivision varchar(50),
	periode varchar(80),
	FE varchar (50),
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
			select
			bkstnr,
			docdate,datum,
			''V1000''  itemcode,
			''10''	btwcode,
			g.oms25 + '' project: ''+ kstdrcode omschrijving,
			g.aantal,
			''399''+ LEFT (kstdrcode,2) debnr,
			reknr,
			bdr_hfl/aantal prijs,
			 bdr_hfl bedrag, g.kstdrcode, g.project projectcode
			,g.kstdrcode uwref,
			1 res_id,
				@division_current,
			(year(docdate)*100+DATEPART (week,docdate) ),
			(select StringValue from [' + @division_current  + ']..Settings
			 where SettingGroup =''eaccount'' and settingname =''VATFiscalGroupNo'' ) as FE
			from [' + @division_current  + ']..gbkmut g
			where g.dagbknr= '' 98''
			And transtype not in( ''V'',''B'') AND (transsubtype <> ''X'')
			and kstdrcode is not null and project is not null

		'

		insert into #result
		exec sp_executesql @query,N'@division_current varchar(50)
                               ',
                                @division_current = @division_current

		set @counter_current = @counter_current + 1
	end





--select * from #check -- tbv test
select
bkstnr,
docdate,
datum,
case when
Isnull(FE, '') <> '' and LEFT (kstdrcode,2) in ('12','21','22','23','24','25','41','42','44','46','81','61')--tussen FE
then 'V1006' else 'V1007' end itemcode,
case when
Isnull(FE, '') <> '' and LEFT (kstdrcode,2) in ('12','21','22','23','24','25','41','42','44','46','81','61')--tussen FE
then '13' else '10' end btwcode,
omschrijving,
aantal,
debnr,
reknr,
prijs,
bedrag,
kstdrcode,
projectcode,
uwref,
res_id,
targetDivision,
targetDivision+'-'+debnr+'-'+rtrim(uwref)+'-'+periode as groepering
from #result
where  targetDivision+'-'+debnr+'-'+rtrim(uwref)+'-'+periode Not IN (SELECT freefield1 FROM   #CHECK)
-- order by input-- tbv test
--select * from #divisions -- tbv test
-- EINDE -- opbouwen tabel met kopregel gegevens
drop table #check
drop table #result
drop table #divisions
