<<<<<<< HEAD
/*
=======
/* 
>>>>>>> origin/master
Gemaakt door Jean wijnands en Homeyra Fazli.
07-02-2017*/


<<<<<<< HEAD
Select	ResourceNumber		= right(rtrim(s.PersoneelNo),9),
		ResourceInlogcode	= right(rtrim(s.PersoneelNo),9),
        ResourceSofinummer	= max(s.BSN ),
	    ResourceAchternaam	= max(s.Achternaam),

/* Onderstaande twee statements toegevoegd */
	    ResourceVoornaam	= max(s.Voornaam),
	    ResourceTussenvoegsel	= max(s.Tussenvoegsel),
	    ResourceInitialen	= max(s.Initialen),

		OrganisatieDivisie	= '5' + convert(varchar(10),left(max(s.ProjectNr),2)),
		ResourceType		= 'E',
		ResourceGeslacht	= 'M',
		ResourceStatus		= 'A',
		ResourceCostCenter  =  convert(varchar(10),left(max(s.ProjectNr),2))+'CC'

=======
Select	ResourceNumber		= right(rtrim(s.PersoneelNo),7), 
		ResourceInlogcode	= right(rtrim(s.PersoneelNo),7),
        ResourceSofinummer	= max(s.BSN ),
	    ResourceAchternaam	= max(s.Achternaam), 
	    
/* Onderstaande twee statements toegevoegd */
	    ResourceVoornaam	= max(s.Voornaam),
	    ResourceTussenvoegsel	= max(s.Tussenvoegsel),	     
	    ResourceInitialen	= max(s.Initialen), 
	    
		OrganisatieDivisie	= '5' + convert(varchar(10),left(max(s.ProjectNr),2)),
		ResourceType		= 'E', 
		ResourceGeslacht	= 'M',
		ResourceStatus		= 'A',
		ResourceCostCenter  =  convert(varchar(10),left(max(s.ProjectNr),2))+'CC'
		
>>>>>>> origin/master
From SagroMedewerker s


/* onderstaande statement de rtrim 7 veranderd in een rtrim 9 */
<<<<<<< HEAD
	left join [Syn_ent]..humres h on h.res_id =  right(rtrim(s.PersoneelNo),9)
=======
	left join [Syn_ent]..humres h on h.res_id =  right(rtrim(s.PersoneelNo),9) 
>>>>>>> origin/master

where	1=1
		and ISNUMERIC(PersoneelNo) = 1
		and h.res_id is  null

group by s.PersoneelNo
