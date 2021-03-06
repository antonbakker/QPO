DECLARE @Division INT = 21


SELECT
  QDWH.dbo.QSagroSoftUrenOH.DatumUrenReg AS datum,
  QDWH.dbo.QSagroSoftUrenOH.Uren AS aantal,
  QDWH.dbo.QSagroSoftUrenOH.KostenIntern AS bedrag,
  QDWH.dbo.QSagroSoftUrenOH.Werkzaamheden AS omschrijving,
  QDWH.dbo.QSagroSoftUrenOH.KostenplaatsMaterieel AS kpl,
  -- onderstaande regel aangepast, zodat het juiste rekeningnummer wordt geselecteerd en niet het gedeelte van het projectnummer
  QDWH.dbo.QSagroSoftUrenOH.grootboek AS reknr,
  kstpl.oms25_0 AS kploms,
  humres.res_id AS res_id,
  'R' + convert(varchar(10), Nr + 1) + 'W' + CONVERT(Varchar(10), DATEPART(week, DatumUrenReg))+'OH' AS consref,
  QSagroSoftUrenOH.id AS id,
	QSagroSoftUrenOH.kstdr AS kstdr

FROM
  QDWH.dbo.QSagroSoftUrenOH
    LEFT OUTER JOIN humres ON QDWH.dbo.QSagroSoftUrenOH.BSN COLLATE database_default = humres.socsec_nr
    LEFT OUTER JOIN kstpl ON QDWH.dbo.QSagroSoftUrenOH.KostenplaatsMaterieel COLLATE database_default = kstpl.kstplcode

WHERE
  (
    (LEN(ProjectNr) = 8 and LEFT(QDWH.dbo.QSagroSoftUrenOH.ProjectNr, 2) = @Division) OR
    (LEN(ProjectNr) = 10 and RIGHT(LEFT(QDWH.dbo.QSagroSoftUrenOH.ProjectNr, 4),2) = @Division)
  )
  AND emp_stat ='A'
  AND QSagroSoftUrenOH.id not in (select * from [QDWH]..Q_idcontrole_oh)

union all

SELECT
  QDWH.dbo.QSagroSoftUrenOH.DatumUrenReg AS datum,
  QDWH.dbo.QSagroSoftUrenOH.Uren AS aantal,
  cast(QDWH.dbo.QSagroSoftUrenOH.KostenIntern AS float) *-1 AS bedrag,
  QDWH.dbo.QSagroSoftUrenOH.Werkzaamheden AS omschrijving,
  '' AS kpl,
  '8997' AS reknr,
  kstpl.oms25_0 AS kploms,
  humres.res_id AS res_id,
  'R' + convert(varchar(10), Nr + 1) + 'W' + CONVERT(Varchar(10), DATEPART(week,DatumUrenReg))+'OH' AS consref,
  QSagroSoftUrenOH.id AS id,
	QSagroSoftUrenOH.kstdr AS kstdr

FROM
  QDWH.dbo.QSagroSoftUrenOH
    LEFT OUTER JOIN humres ON QDWH.dbo.QSagroSoftUrenOH.BSN COLLATE database_default = humres.socsec_nr
    LEFT OUTER JOIN kstpl ON QDWH.dbo.QSagroSoftUrenOH.KostenplaatsMaterieel COLLATE database_default = kstpl.kstplcode

WHERE
  (
    (LEN(ProjectNr) = 8 and LEFT(QDWH.dbo.QSagroSoftUrenOH.ProjectNr, 2) = @Division) OR
    (LEN(ProjectNr) = 10 and RIGHT(LEFT(QDWH.dbo.QSagroSoftUrenOH.ProjectNr, 4),2) = @Division)
  )
  AND emp_stat ='A'
  AND QSagroSoftUrenOH.id not in (select * from [QDWH]..Q_idcontrole_oh)
