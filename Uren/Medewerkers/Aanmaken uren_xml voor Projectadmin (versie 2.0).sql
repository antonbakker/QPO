set transaction isolation level read uncommitted
DECLARE @Projectadmin INT = 21

SELECT
	res_id AS medew,
	'5910' AS reknr,
	LEFT(ProjectNr, 2) AS adm,
	DatumUrenReg AS datum,
	Uren AS aantal,
	KostenIntern AS bedrag,
	ISNULL(Voornaam, '') + 	' ' + ISNULL(Tussenvoegsel, '') + ' ' +	ISNULL(Achternaam, '') AS omschrijving,
	ProjectNr AS project,
	PersoneelNo,
	humres.socsec_nr,
	BSN,
	Achternaam,
	humres.fullname,
	'R'+convert(varchar(10),Nr+1)+'W'+ CONVERT(Varchar(10), DATEPART (week,DatumUrenReg))+'U'as consref,
	QSagroSoftUren.id,
	QSagroSoftUren.kstdr

FROM
	QDWH.dbo.QSagroSoftUren
	LEFT OUTER JOIN	humres ON QDWH.dbo.QSagroSoftUren.BSN = humres.socsec_nr collate database_default

WHERE
	(LEFT(QDWH.dbo.QSagroSoftUren.ProjectNr, 2) = @Projectadmin)
	and humres.res_id is not null
	and emp_stat ='A'
/*			and ProjectNr in (select ProjectNr collate database_default from PRProject) */
			-- indirecte projecten uitsluiten:
	and  left(right([ProjectNr],4),3) not in (999)
	and QSagroSoftUren.id not in (select freefield5 from [QDWH]..Q_idcontrole_u)

union all

SELECT
	res_id AS medew,
	'8999' AS reknr,
	LEFT(ProjectNr, 2) AS adm,
	DatumUrenReg AS datum,
	Uren AS	aantal,
	cast(KostenIntern as float)*-1 AS bedrag,
	ISNULL(Voornaam, '') + 	' ' + ISNULL(Tussenvoegsel, '') + ' ' +	ISNULL(Achternaam, '') AS omschrijving,
	'' AS project,
	PersoneelNo,
	humres.socsec_nr,
	BSN,
	Achternaam,
	humres.fullname,
	'R'+convert(varchar(10),Nr+1)+'W'+ CONVERT(Varchar(10), DATEPART (week,DatumUrenReg))+'U'as consref,
	QSagroSoftUren.id,
	QSagroSoftUren.kstdr

FROM
	QDWH.dbo.QSagroSoftUren
		LEFT OUTER JOIN humres ON QDWH.dbo.QSagroSoftUren.BSN = humres.socsec_nr collate database_default

WHERE
	(LEFT(QDWH.dbo.QSagroSoftUren.ProjectNr, 2) = @Projectadmin)
	-- voorwaarde medewerker en project bekend in Exact alleen administatie 21
	and humres.res_id is not null
/*	and ProjectNr in (select ProjectNr collate database_default from PRProject) */
	and emp_stat ='A'
		-- indirecte projecten uitsluiten:
	and  left(right([ProjectNr],4),3)  not in (999)
	and QSagroSoftUren.id not in (select freefield5 from [qdwh]..Q_idcontrole_u)
