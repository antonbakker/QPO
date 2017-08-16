/* 
Voorwaarden:
- Werk bevat realtienummer in de vorm van <Relatienummer>[ | <Relatienaam>]
- Relatienummer komt overeen met het relatienummer in Exact
- Werk bevat vijf of meer posities
- Werk bevat op de zesde positie een spatie (indien meer dan vijf posities)
- Werk heeft meer of minder dan 8 karakters
- Werk is 5 posities lang, of heeft op de zesde positie een spatie
- Projectnummer exact 8 posities
- Projectnummer bestaat uitsluitend uit getallen
- 

*/


Update qW
set
     qW.Projectnummer = P.ProjectNr,
		 qW.Projectomschrijving = P.Projectomschrijving

FROM
    dbo.qWegingen as qW
		JOIN [DWH].[dbo].qProjectPRExact AS P ON left(qW.Project, 8) = Left(P.ProjectNr, 8)
where
	LEN(P.ProjectNr) = 8
	-- AND ISNUMERIC(LEFT(qW.Project, 8))