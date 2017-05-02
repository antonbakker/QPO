/* Dit is de nette query, waarbij in de export query de grootboekrekeningen worden meegegeven */

set transaction isolation level read uncommitted
DECLARE @Division INT = 47

SELECT
	1 AS medew,
	grootboek AS reknr,
	LEFT(kstdr, 2) AS adm,
	DatumUrenReg AS datum,
	Uren AS aantal,
	cast(KostenIntern as float) AS bedrag,
	ISNULL(Voornaam, '') + ' ' + ISNULL(Tussenvoegsel, '') + ' ' + ISNULL(Achternaam, '') AS omschrijving,
	kstdr AS project,
	ProjectNr AS ICkstdr,
	'ICR'+convert(varchar(10),Nr+1)+'W'+ CONVERT(Varchar(10), DATEPART (week,DatumUrenReg))+'U'as consref,
	QSagroSoftUrenIC.id,
	'' AS kstdr,
	99900 + RIGHT(LEFT(ProjectNr,4),2) AS crdnr

FROM
	QDWH.dbo.QSagroSoftUrenIC

WHERE
	LEFT(QDWH.dbo.QSagroSoftUrenIC.kstdr, 2) = @Division
	and  left(right(kstdr,4),3)  not in (999)
	and QSagroSoftUrenIC.id not in (select  freefield5 from [QDWH]..Q_idcontrole_u_IC)

union all

SELECT
 	1 AS medew,
	dekking AS reknr,
	LEFT(kstdr, 2) AS adm,
	DatumUrenReg AS datum,
	Uren AS	aantal,
	cast(KostenIntern as float)*-1 AS bedrag,
	ISNULL(Voornaam, '') + ' ' + ISNULL(Tussenvoegsel, '') + ' ' + ISNULL(Achternaam, '') AS omschrijving,
	'' AS project,
	ProjectNr AS ICkstdr,
	'ICR'+convert(varchar(10),Nr+1)+'W'+ CONVERT(Varchar(10), DATEPART (week,DatumUrenReg))+'U'as consref,
	QSagroSoftUrenIC.id,
	'' AS kstdr,
	99900 + RIGHT(LEFT(ProjectNr,4),2) AS crdnr


FROM
	QDWH.dbo.QSagroSoftUrenIC

WHERE
	LEFT(QDWH.dbo.QSagroSoftUrenIC.kstdr, 2) = @Division
	and left(right(kstdr,4),3) not in (999)
	and QSagroSoftUrenIC.id not in (select freefield5 from [qdwh]..Q_idcontrole_u_IC)
