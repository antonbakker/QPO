/* Dit is de nette query, waarbij in de export query de grootboekrekeningen worden meegegeven */
/* In deze query wordt het projectnummer voorafgegaan door 99 als het om door te belasten uren gaat | indien voorzien van een kostenplaats */

set transaction isolation level read uncommitted
DECLARE @Division INT = 21

SELECT
	humres.res_id AS medew,
	grootboek AS reknr,
	LEFT(ProjectNr, 2) AS adm,
	DatumUrenReg AS datum,
	Uren AS aantal,
	KostenIntern AS bedrag,
	ISNULL(Voornaam, '') + ' ' + ISNULL(Tussenvoegsel, '') + ' ' + ISNULL(Achternaam, '') AS omschrijving,
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
	LEFT OUTER JOIN	humres
		ON QDWH.dbo.QSagroSoftUren.BSN = humres.socsec_nr collate database_default
WHERE
	(
		(LEN(ProjectNr) = 8 and LEFT(QDWH.dbo.QSagroSoftUren.ProjectNr, 2) = @Division) OR
		(LEN(ProjectNr) = 10 and RIGHT(LEFT(QDWH.dbo.QSagroSoftUren.ProjectNr, 4),2) = @Division)
	)
	and humres.res_id is not null
	and emp_stat ='A'
	-- onderstaande regel verwijderd, omdat anders de nieuwe projecten niet worden aagnemaakt.
/*	and ProjectNr in (select ProjectNr collate database_default from PRProject) */
			-- indirecte projecten uitsluiten:
	and QSagroSoftUren.id not in (select  freefield5 from [QDWH]..Q_idcontrole_u)

union all

SELECT
	humres.res_id AS medew,
	dekking AS reknr,
	LEFT(ProjectNr, 2) AS adm,
	DatumUrenReg AS datum,
	Uren AS	aantal,
	cast(KostenIntern as float)*-1 AS bedrag,
	ISNULL(Voornaam, '') + ' ' + ISNULL(Tussenvoegsel, '') + ' ' + ISNULL(Achternaam, '') AS omschrijving,
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
	LEFT OUTER JOIN humres
			ON QDWH.dbo.QSagroSoftUren.BSN = humres.socsec_nr collate database_default

WHERE
	(
		(LEN(ProjectNr) = 8 and LEFT(QDWH.dbo.QSagroSoftUren.ProjectNr, 2) = @Division) OR
		(LEN(ProjectNr) = 10 and RIGHT(LEFT(QDWH.dbo.QSagroSoftUren.ProjectNr, 4),2) = @Division)
	)
			-- voorwaarde medewerker en project bekend in Exact alleen administatie 21
	and humres.res_id is not null
		-- onderstaande regel verwijderd, omdat anders de nieuwe projecten niet worden aagnemaakt.
/*		and ProjectNr in (select ProjectNr collate database_default	from PRProject) */
	and emp_stat ='A'
		-- indirecte projecten uitsluiten:
	and QSagroSoftUren.id not in (select freefield5 from [qdwh]..Q_idcontrole_u)
