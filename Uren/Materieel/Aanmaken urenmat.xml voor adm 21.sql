set transaction isolation level read uncommitted

DECLARE @Division INT = 21
DECLARE @Administrator INT = 1

SELECT
	LEFT(QSagroSoftUrenMat.ProjectNr, 2) AS adm,
	grootboek AS reknr,
	QSagroSoftUrenMat.ProjectNr AS project,
	QSagroSoftUrenMat.DatumUrenReg AS datum,
	KostenPlaats + ' ' + Isnull(kstpl.oms25_0, QSagroSoftUrenMat.Omschrijving) collate database_default AS omschrijving,
  QSagroSoftUrenMat.KostenPlaats AS kpl,
  QSagroSoftUrenMat.Uren AS aantal,
  QSagroSoftUrenMat.KostenIntern AS bedrag,
  Isnull(kstpl.oms25_0, QSagroSoftUrenMat.Omschrijving) AS kploms,
         -- OnbekendeKostenplaats worden automatisch aangemaakt met omschrijving uit SSOFT
  'R' + convert(varchar(10), Nr+1) + 'W' + CONVERT(Varchar(10), DATEPART(week,DatumUrenReg)) + 'MT' AS consref,
	QSagroSoftUrenMat.id,
	@Administrator AS medew

FROM
	[qdwh]..QSagroSoftUrenMat
	LEFT OUTER JOIN kstpl ON QSagroSoftUrenMat.KostenPlaats = kstpl.kstplcode collate database_default

WHERE
	LEFT(QSagroSoftUrenMat.ProjectNr, 2) = @Division
	-- onderstaande conditite verwijderd om er voor te zorgen dat projecten worden aangemaakt
/*	AND QSagroSoftUrenMat.ProjectNr IN (SELECT ProjectNr collate database_default FROM PRProject) */
	AND QSagroSoftUrenMat.id not in (select * from [QDWH]..Q_idcontrole_mat)

union all

SELECT
	LEFT(QSagroSoftUrenMat.ProjectNr, 2) AS adm,
	dekking AS reknr,
	'' AS project,
	QSagroSoftUrenMat.DatumUrenReg AS datum,
	QSagroSoftUrenMat.Werkzaamheden AS omschrijving,
  '' AS kpl,
  QSagroSoftUrenMat.Uren AS aantal,
  CAST(QSagroSoftUrenMat.KostenIntern AS float)	*-1 AS bedrag,
	Isnull(kstpl.oms25_0, QSagroSoftUrenMat.Omschrijving) AS kploms,
  -- Kostenplaats worden automatisch aangemaakt
  'R' + convert(varchar(10),Nr+1) + 'W' + CONVERT(Varchar(10), DATEPART(week,DatumUrenReg)) + 'MT' AS consref,
	QSagroSoftUrenMat.id,
	@Administrator AS medew

FROM
	[qdwh]..QSagroSoftUrenMat
	LEFT OUTER JOIN kstpl ON QSagroSoftUrenMat.KostenPlaats = kstpl.kstplcode collate database_default

WHERE
	LEFT(QSagroSoftUrenMat.ProjectNr, 2) = @Division
	-- onderstaande conditite verwijderd om er voor te zorgen dat projecten worden aangemaakt
/*	AND  QSagroSoftUrenMat.ProjectNr IN (SELECT ProjectNr collate database_default FROM PRProject) */
		 				-- project moet aanwezig zijn in Exact
	AND QSagroSoftUrenMat.id not in (select * from [QDWH]..Q_idcontrole_mat)
