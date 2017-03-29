SELECT   LEFT(QSagroSoftUrenMat.ProjectNr, 2)	AS adm,
		 5920									AS reknr, 
		 QSagroSoftUrenMat.ProjectNr			as project,
		 QSagroSoftUrenMat.DatumUrenReg			AS datum, 
		 KostenPlaats+' '+ Isnull(kstpl.oms25_0,QSagroSoftUrenMat.Omschrijving)	 collate database_default	AS omschrijving, 
         QSagroSoftUrenMat.KostenPlaats			as kpl		,
         QSagroSoftUrenMat.Uren					as aantal		,
         QSagroSoftUrenMat.KostenIntern			as bedrag		,
         Isnull(kstpl.oms25_0,QSagroSoftUrenMat.Omschrijving) as kploms
         -- OnbekendeKostenplaats worden automatisch aangemaakt met omschrijving uit SSOFT  
         ,'R'+convert(varchar(10),Nr+1)+'W'+ CONVERT(Varchar(10), DATEPART (week,DatumUrenReg))+'MT'as consref,QSagroSoftUrenMat.id
FROM         [qdwh]..QSagroSoftUrenMat LEFT OUTER JOIN
                      kstpl ON QSagroSoftUrenMat.KostenPlaats = kstpl.kstplcode collate database_default
WHERE     LEFT(QSagroSoftUrenMat.ProjectNr, 2) = 21 
		  AND  QSagroSoftUrenMat.ProjectNr 
				IN          (SELECT     ProjectNr  collate database_default  FROM   PRProject)
				and QSagroSoftUrenMat.id not in (select * from [QDWH]..Q_idcontrole_mat)
	
				

union all

SELECT   LEFT(QSagroSoftUrenMat.ProjectNr, 2)	AS adm,
		 8998									AS reknr, 
		 ''										as project		,
		 QSagroSoftUrenMat.DatumUrenReg			AS datum, 
		 QSagroSoftUrenMat.Werkzaamheden		AS omschrijving, 
         ''										as kpl		,
         QSagroSoftUrenMat.Uren					as aantal		,
         cast(QSagroSoftUrenMat.KostenIntern as float)	*-1		as bedrag		,
         Isnull(kstpl.oms25_0,QSagroSoftUrenMat.Omschrijving) as kploms
         -- Kostenplaats worden automatisch aangemaakt
         ,'R'+convert(varchar(10),Nr+1)+'W'+ CONVERT(Varchar(10), DATEPART (week,DatumUrenReg))+'MT'as consref,QSagroSoftUrenMat.id
FROM         [qdwh]..QSagroSoftUrenMat LEFT OUTER JOIN
                      kstpl ON QSagroSoftUrenMat.KostenPlaats = kstpl.kstplcode  collate database_default
      
                      
WHERE     LEFT(QSagroSoftUrenMat.ProjectNr, 2) = 21 
		  AND  QSagroSoftUrenMat.ProjectNr 
		 				IN          (SELECT     ProjectNr  collate database_default FROM   PRProject)
		 				-- project moet aanwezig zijn in Exact
		 			and QSagroSoftUrenMat.id not in (select * from [QDWH]..Q_idcontrole_mat)