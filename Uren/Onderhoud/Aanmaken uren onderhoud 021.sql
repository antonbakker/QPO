set transaction isolation level read uncommitted
DECLARE @Division INT = 21

SELECT
  QDWH.dbo.QSagroSoftUrenOH.DatumUrenReg AS datum,
  QDWH.dbo.QSagroSoftUrenOH.Uren AS aantal,
  QDWH.dbo.QSagroSoftUrenOH.KostenIntern AS bedrag,
  QDWH.dbo.QSagroSoftUrenOH.Werkzaamheden AS omschrijving,
  QDWH.dbo.QSagroSoftUrenOH.KostenplaatsMaterieel AS kpl,
  RIGHT(QDWH.dbo.QSagroSoftUrenOH.ProjectNr, 4) AS reknr,
  kstpl.oms25_0,
  humres.res_id,
  'R'+convert(varchar(10),Nr+1)+'W'+ CONVERT(Varchar(10), DATEPART (week,DatumUrenReg))+'OH'as consref,QSagroSoftUrenOH.id

FROM
  QDWH.dbo.QSagroSoftUrenOH
  LEFT OUTER JOIN humres ON QDWH.dbo.QSagroSoftUrenOH.BSN = humres.socsec_nr
  LEFT OUTER JOIN kstpl ON QDWH.dbo.QSagroSoftUrenOH.KostenplaatsMaterieel COLLATE database_default = kstpl.kstplcode

WHERE
  (LEFT(QDWH.dbo.QSagroSoftUrenOH.ProjectNr, 2) = @Division)
  and emp_stat ='A'
  and QSagroSoftUrenOH.id not in (select * from [QDWH]..Q_idcontrole_oh)

union all

SELECT
  QDWH.dbo.QSagroSoftUrenOH.DatumUrenReg AS datum,
  QDWH.dbo.QSagroSoftUrenOH.Uren AS aantal,
  cast(QDWH.dbo.QSagroSoftUrenOH.KostenIntern as float) *-1 AS bedrag,
  QDWH.dbo.QSagroSoftUrenOH.Werkzaamheden AS omschrijving,
  '' AS kpl,
  '8997' AS reknr, kstpl.oms25_0,
  humres.res_id,
  'R'+convert(varchar(10),Nr+1)+'W'+ CONVERT(Varchar(10), DATEPART (week,DatumUrenReg))+'OH'as consref,QSagroSoftUrenOH.id

FROM
  QDWH.dbo.QSagroSoftUrenOH
  LEFT OUTER JOIN humres ON QDWH.dbo.QSagroSoftUrenOH.BSN = humres.socsec_nr
  LEFT OUTER JOIN kstpl ON QDWH.dbo.QSagroSoftUrenOH.KostenplaatsMaterieel COLLATE database_default = kstpl.kstplcode

WHERE
  LEFT(QDWH.dbo.QSagroSoftUrenOH.ProjectNr, 2) = @Division
  and emp_stat ='A'
  and QSagroSoftUrenOH.id not in (select * from [QDWH]..Q_idcontrole_oh)
