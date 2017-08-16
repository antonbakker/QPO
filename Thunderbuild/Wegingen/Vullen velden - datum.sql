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

FROM
    dbo.qWegingen as qW