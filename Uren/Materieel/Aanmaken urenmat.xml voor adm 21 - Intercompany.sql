set transaction isolation level read uncommitted

DECLARE @Division INT = 47
DECLARE @Administrator INT = 1

SELECT
	LEFT(QSagroSoftUrenMatIC.kstdr, 2) AS adm,
	grootboek AS reknr,
	QSagroSoftUrenMatIC.kstdr AS project,
	QSagroSoftUrenMatIC.DatumUrenReg AS datum,
	KostenPlaats + ' | ' + Isnull(kstpl.oms25_0,  QSagroSoftUrenMatIC.Omschrijving) collate database_default + ' | ' + QSagroSoftUrenMatIC.Werkzaamheden AS omschrijving,
  QSagroSoftUrenMatIC.Uren AS aantal,
  CAST(QSagroSoftUrenMatIC.KostenIntern AS float) AS bedrag,
	ProjectNr AS ICkstdr,
  Isnull(kstpl.oms25_0, QSagroSoftUrenMatIC.Omschrijving) AS kploms,
         -- OnbekendeKostenplaats worden automatisch aangemaakt met omschrijving uit SSOFT
  'ICR' + convert(varchar(10), Nr+1) + 'W' + CONVERT(Varchar(10), DATEPART(week,DatumUrenReg)) + 'MT' AS consref,
	QSagroSoftUrenMatIC.id,
	@Administrator AS medew,
	99900 + RIGHT(LEFT(ProjectNr,4),2) AS crdnr


FROM
	[qdwh].. QSagroSoftUrenMatIC
	LEFT OUTER JOIN kstpl ON  QSagroSoftUrenMatIC.KostenPlaats = kstpl.kstplcode collate database_default

WHERE
	LEFT(QSagroSoftUrenMatIC.kstdr,2) = @Division
	-- onderstaande conditite verwijderd om er voor te zorgen dat projecten worden aangemaakt
/*	AND  QSagroSoftUrenMatIC.ProjectNr IN (SELECT ProjectNr collate database_default FROM PRProject) */
	AND QSagroSoftUrenMatIC.id not in (select * from [QDWH]..Q_idcontrole_mat_IC)

union all

SELECT
	LEFT(QSagroSoftUrenMatIC.kstdr, 2) AS adm,
	dekking AS reknr,
	'' AS project,
	QSagroSoftUrenMatIC.DatumUrenReg AS datum,
	KostenPlaats + ' | ' + Isnull(kstpl.oms25_0,  QSagroSoftUrenMatIC.Omschrijving) collate database_default + ' | ' + QSagroSoftUrenMatIC.Werkzaamheden AS omschrijving,
  QSagroSoftUrenMatIC.Uren AS aantal,
  CAST(QSagroSoftUrenMatIC.KostenIntern AS float)	*-1 AS bedrag,
	ProjectNr AS ICkstdr,
	Isnull(kstpl.oms25_0, QSagroSoftUrenMatIC.Omschrijving) AS kploms,
  -- Kostenplaats worden automatisch aangemaakt
  'ICR' + convert(varchar(10),Nr+1) + 'W' + CONVERT(Varchar(10), DATEPART(week,DatumUrenReg)) + 'MT' AS consref,
	QSagroSoftUrenMatIC.id,
	@Administrator AS medew,
	99900 + RIGHT(LEFT(ProjectNr,4),2) AS crdnr


FROM
	[qdwh].. QSagroSoftUrenMatIC
	LEFT OUTER JOIN kstpl ON QSagroSoftUrenMatIC.KostenPlaats = kstpl.kstplcode collate database_default

WHERE
	LEFT(QSagroSoftUrenMatIC.kstdr, 2) = @Division
	-- onderstaande conditite verwijderd om er voor te zorgen dat projecten worden aangemaakt
/*	AND   QSagroSoftUrenMatIC.ProjectNr IN (SELECT ProjectNr collate database_default FROM PRProject) */
		 				-- project moet aanwezig zijn in Exact
	AND QSagroSoftUrenMatIC.id not in (select * from [QDWH]..Q_idcontrole_mat_IC)
