set transaction isolation level read uncommitted
DECLARE @Division INT = 21

SELECT
	humres.res_id AS medew,
	grootboek AS reknr,
	LEFT(ProjectNr, 2) AS adm,
	DatumUrenReg AS datum,
	Uren AS aantal,
	KostenIntern AS bedrag,
	ISNULL(Voornaam, '') 	+ ' ' + ISNULL(Tussenvoegsel, '') + ' ' + ISNULL(Achternaam, '') AS omschrijving,
	ProjectNr AS project,
	PersoneelNo,
	humres.socsec_nr,
	BSN,
	Achternaam,
	humres.fullname,
	'R'+convert(varchar(10),Nr+1)+'W'+ CONVERT(Varchar(10), DATEPART (week,DatumUrenReg))+'U'as consref,QSagroSoftUren.id,QSagroSoftUren.kstdr


FROM
	QDWH.dbo.QSagroSoftUren
	LEFT OUTER JOIN	humres
		ON QDWH.dbo.QSagroSoftUren.BSN = humres.socsec_nr collate database_default
WHERE
	(LEFT(QDWH.dbo.QSagroSoftUren.ProjectNr, 2) = @Division)
	and humres.res_id is not null
	and emp_stat ='A'
	-- onderstaande regel verwijderd, omdat anders de nieuwe projecten niet worden aagnemaakt.
/*	and ProjectNr in (select ProjectNr collate database_default from PRProject) */
			-- indirecte projecten uitsluiten:
	and  left(right([ProjectNr],4),3)  not in (999)
	and QSagroSoftUren.id not in (select  freefield5 from  [QDWH]..Q_idcontrole_u)

union all

SELECT
	humres.res_id AS medew,
	dekking AS reknr,
	LEFT(ProjectNr, 2) AS adm,
	DatumUrenReg AS datum,
	Uren AS	aantal,
	cast(KostenIntern as float)*-1 AS bedrag,
	ISNULL(Voornaam, '') 	+ ' ' + ISNULL(Tussenvoegsel, '') + ' ' + ISNULL(Achternaam, '') AS omschrijving,
	'' AS project,
	PersoneelNo,
	humres.socsec_nr,
	BSN,
	Achternaam,
	humres.fullname,
	'R'+convert(varchar(10),Nr+1)+'W'+ CONVERT(Varchar(10), DATEPART (week,DatumUrenReg))+'U'as consref,QSagroSoftUren.id,QSagroSoftUren.kstdr

FROM
	QDWH.dbo.QSagroSoftUren
	LEFT OUTER JOIN humres
			ON QDWH.dbo.QSagroSoftUren.BSN = humres.socsec_nr collate database_default

WHERE
	(LEFT(QDWH.dbo.QSagroSoftUren.ProjectNr, 2) = @Division)
			-- voorwaarde medewerker en project bekend in Exact alleen administatie 21
		and humres.res_id is not null
		-- onderstaande regel verwijderd, omdat anders de nieuwe projecten niet worden aagnemaakt.
/*		and ProjectNr in (select ProjectNr collate database_default	from PRProject) */
		and emp_stat ='A'
		-- indirecte projecten uitsluiten:
		and  left(right([ProjectNr],4),3) not in (999)
		and QSagroSoftUren.id not in (select  freefield5 from  [qdwh]..Q_idcontrole_u)
