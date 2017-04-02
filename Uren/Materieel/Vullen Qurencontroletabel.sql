insert into Qurencontrole
SELECT     'R' + CONVERT(varchar(10), Nr + 1) + 'W' + CONVERT(Varchar(10), DATEPART(week, DatumUrenReg)) + 'MT' AS ref, Created AS aanmaakdatum, ID, 
                      ProjectNr
FROM         QSagroSoftUrenMat