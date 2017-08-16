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
	qW.cmp_code = R.cmp_code,
	qW.cmp_name = R.cmp_name

FROM
    dbo.qWegingen as qW
		JOIN [DWH].[dbo].qRelaties AS R ON left(qW.Werk, 5) = right(R.cmp_code, 5)
where
		CASE
			WHEN (Len(qW.Werk) >= 6 and Right(left(qW.Werk, 6), 1) = ' ') THEN 1
			WHEN Len(qW.Werk) = 8 THEN 0
			WHEN len(qW.Werk) = 5 THEN 1
		END

