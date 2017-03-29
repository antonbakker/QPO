set transaction isolation level read uncommitted
SELECT  res_id		 medew, 
		'5910'				 reknr,
		LEFT(ProjectNr, 2)	 adm, 
		DatumUrenReg		 datum, 
		Uren				 aantal,
		KostenIntern		 bedrag,
		Naam		 omschrijving,
		ProjectNr			 project,
		PersoneelNo,humres.socsec_nr,BSN, Naam,humres.fullname
		,'R'+convert(varchar(10),Nr+1)+'W'+ CONVERT(Varchar(10), DATEPART (week,DatumUrenReg))+'U'as consref,QSagroSoftUren.id

FROM         QDWH.dbo.QSagroSoftUren LEFT OUTER JOIN
                      humres ON QDWH.dbo.QSagroSoftUren.BSN = humres.socsec_nr collate database_default
WHERE     (LEFT(QDWH.dbo.QSagroSoftUren.ProjectNr, 2) = 21) and humres.res_id is not null and emp_stat ='A'
			and ProjectNr in (select ProjectNr collate database_default from PRProject)
			-- indirecte projecten uitsluiten:
			and  left(right([ProjectNr],4),3)  not in (999)
			and QSagroSoftUren.id not in (select  freefield5 from  [QDWH]..Q_idcontrole_u)

union all

SELECT  res_id		 medew, 
		'8999'				 reknr,
		LEFT(ProjectNr, 2)	 adm, 
		DatumUrenReg		 datum, 
		Uren				 aantal,
		cast(KostenIntern as float)*-1		 bedrag,
		Naam		 omschrijving,
		''					 project,
		PersoneelNo,humres.socsec_nr,BSN, Naam,humres.fullname
		,'R'+convert(varchar(10),Nr+1)+'W'+ CONVERT(Varchar(10), DATEPART (week,DatumUrenReg))+'U'as consref,QSagroSoftUren.id

FROM         QDWH.dbo.QSagroSoftUren LEFT OUTER JOIN
                      humres ON QDWH.dbo.QSagroSoftUren.BSN = humres.socsec_nr collate database_default
                      
WHERE     (LEFT(QDWH.dbo.QSagroSoftUren.ProjectNr, 2) = 21) 
			-- voorwaarde medewerker en project bekend in Exact alleen administatie 21
		   and humres.res_id is not null and ProjectNr in (select ProjectNr collate database_default from PRProject)and emp_stat ='A'
		-- indirecte projecten uitsluiten:
			and  left(right([ProjectNr],4),3)  not in (999)
				and QSagroSoftUren.id not in (select  freefield5 from  [qdwh]..Q_idcontrole_u)