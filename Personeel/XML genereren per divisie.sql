/* aangepast door A. Bakker */
/*
	Personeelsnummer:
	laatste twee cijfers van de Divisie / Administatienummer, e.g. 21 voor SAZ
	Laatste 7 cijders van het personeelsnummer in BSC */

/*
Gemaakt door Jean wijnands en Homeyra Fazli.
07-02-2017*/

/* Nieuwe administraties beginnen met een 5 */

Select	distinct
		'5' + convert(varchar(10),left(max(s.ProjectNr),2)) as OrganisatieDivisie

From SagroMedewerker s
	left join [Syn_ent]..humres h on h.res_id =  right(rtrim(s.PersoneelNo),9)

where	1=1
		and ISNUMERIC(PersoneelNo) = 1
		and h.res_id is null
		and s.ProjectNr not like '99%'


group by s.PersoneelNo
