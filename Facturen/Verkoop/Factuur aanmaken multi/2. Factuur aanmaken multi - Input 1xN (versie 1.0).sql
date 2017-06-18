set transaction isolation level read uncommitted
--SUBregels
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
					isnull(frsrg.ordernr, ''1'')	 
				FROM
					[' + @division_current  + ']..frsrg 

				UNION ALL
		
				SELECT distinct	
					@division_current,
					isnull(frhsrg.ordernr, ''1'')
				FROM   [' + @division_current  + ']..frhsrg 
			'		
		insert into #check
		exec
			sp_executesql @query,
			N'@division_current varchar(50)',
            @division_current = @division_current
		set @counter_current = @counter_current + 1
	end 
	
	--select * from #check
-- EINDE -- opbouwen tabel met reeds geboekte factuurregels




-- START -- opbouwen tabel met subregel gegevens
create table #result
	(
		id int identity(1,1),
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
		gmid int,
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
			SELECT 
				bkstnr,
				docdate,
				datum,
				''V2000''  itemcode,
				''10''	btwcode,
				case  g.reknr 
					when  ''     5910'' then kstdrcode +'' personeel ''
					when  ''     5920'' then kstdrcode  + '' materieel ''
				end  omschrijving,
				g.aantal,
				''399''+ LEFT (kstdrcode,2) debnr,
				reknr,
				bdr_hfl/aantal prijs,
				bdr_hfl bedrag,
				g.kstdrcode,
				g.project projectcode,
				g.kstdrcode uwref,
				g.id,
				1 res_id,
				@division_current,
				(year(docdate)*100+DATEPART (week,docdate) ),
				(
					SELECT
						StringValue
					FROM
						[' + @division_current  + ']..Settings
					where
						SettingGroup =''eaccount''
						and settingname =''VATFiscalGroupNo'' 
				) as FE
			FROM
				[' + @division_current  + ']..gbkmut g
			WHERE
				g.dagbknr= '' 98''
				AND transtype not in( ''V'',''B'')
				AND (transsubtype <> ''X'') 
				AND kstdrcode is not null
				AND project is not null
			
		'
			
		insert into #result
		exec sp_executesql @query,N'@division_current varchar(50)
                               ',
                                @division_current = @division_current

		set @counter_current = @counter_current + 1
	end 
		




--select * from #check -- tbv test
SELECT 
	bkstnr,
	docdate,
	datum,
	CASE
		WHEN
			Isnull(FE, '') <> '' 
			AND LEFT (kstdrcode,2) in ('12','21','22','23','24','25','41','42','44','46','81','61')--tussen FE
			THEN 'V2006' else 'V2007'
	END itemcode,
	CASE
		WHEN
			Isnull(FE, '') <> '' 
			AND LEFT (kstdrcode,2) in ('12','21','22','23','24','25','41','42','44','46','81','61')--tussen FE
			THEN '13' else '10'
	END btwcode,
	omschrijving,
	aantal,
	debnr,
	reknr,
	prijs,
	bedrag,
	kstdrcode,
	projectcode,
	uwref,
	gmid,
	res_id,
	targetDivision,
	targetDivision+'-'+debnr+'-'+periode as groepering
FROM
	#result
WHERE
	gmid Not IN (SELECT freefield1 FROM   #CHECK) 
ORDER BY
	groepering,
	kstdrcode,
	reknr-- tbv test 
	-select * from #divisions -- tbv test	
	-- EINDE -- opbouwen tabel met kopregel gegevens
drop table #check
drop table #result
drop table #divisions