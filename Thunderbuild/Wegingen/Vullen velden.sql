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
    qW.Jaar = convert(int, RIGHT(left(qW.Datum, 10), 4)),
    qW.Kwartaal = datepart(qq, 
	    RIGHT(left(qW.Datum, 10), 4) +
	    '-' +
	    RIGHT(left(qW.Datum, 5), 2) +
	    '-' +
	    left(qW.Datum, 2)
    ),
    qW.Maand = convert(int, RIGHT(left(qW.Datum, 5), 2)),
    qW.Dag = convert(int, left(qW.Datum, 2)),
    qW.DatumISO = convert(date, 
	    RIGHT(left(qW.Datum, 10), 4) +
	    '-' +
	    RIGHT(left(qW.Datum, 5), 2) +
	    '-' +
	    left(qW.Datum, 2)
    ),
    qW.Week = datepart(ISO_WEEK, 
	    RIGHT(left(qW.Datum, 10), 4) +
	    '-' +
	    RIGHT(left(qW.Datum, 5), 2) +
	    '-' +
	    left(qW.Datum, 2)
    ),
    qW.Tijd = convert(TIME, RIGHT(left(qW.Datum, 16), 5)),
    qW.URL = 'http://app.afvalmelding.nl/begeleidingsbrieven/view/' + qW.Referentie,
    qW.Projectnummer = 
        CASE ISNUMERIC(LEFT(qW.Project, 8)) 
            WHEN 1 THEN LEFT(qW.Project, 8)
            ELSE 0
        END,

	qW.cmp_code = R.cmp_code,
	qW.cmp_name = R.cmp_name,
	
	/*qW.Stroom = ['In' | 'Uit'],
	qW.Locatie = [],
	qW.Mutatie = [],*/

    qW.Modified = 1

FROM
    dbo.qWegingen as qW
		RIGHT JOIN [DWH].[dbo].qRelaties AS R ON left(qW.Werk, 5) = right(R.cmp_code, 5)
where
    ((qW.Modified is NULL) OR
    (qW.Modified = 0)) AND
		CASE
			WHEN (Len(qW.Werk) >= 6 and Right(left(qW.Werk, 6), 1) = ' ') THEN 1
			WHEN Len(qW.Werk) = 8 THEN 0
			WHEN len(qW.Werk) = 5 THEN 1
		END

