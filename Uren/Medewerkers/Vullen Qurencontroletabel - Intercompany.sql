insert into QurencontroleIC
select 'ICR'+convert(varchar(10),Nr+1)+'W'+ CONVERT(Varchar(10), DATEPART (week,DatumUrenReg))+'U'as Referentie,
Created AS Aanmaakdatum,
id AS Urenid,
ProjectNr as Projectnr,
Uren AS Uren,
Werkzaamheden AS Werkzaamheden
from QSagroSoftUrenIC
