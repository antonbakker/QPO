insert into Qurencontrole
select 'R'+convert(varchar(10),Nr+1)+'W'+ CONVERT(Varchar(10), DATEPART (week,DatumUrenReg))+'U'as ref, 
Created aanmaakdatum,id,ProjectNr
from QSagroSoftUren