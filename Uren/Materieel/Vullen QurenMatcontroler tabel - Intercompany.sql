insert into QurencontroleIC
SELECT
  'ICR' + CONVERT(varchar(10), Nr + 1) + 'W' + CONVERT(Varchar(10), DATEPART(week, DatumUrenReg)) + 'MT' AS Referentie,
  Created AS aanmaakdatum,
  ID AS Urenid,
  ProjectNr AS Projectnr,
  Uren AS Uren,
  Werkzaamheden AS Werkzaamheden,
  Type AS Type
FROM
  QSagroSoftUrenMatIC
