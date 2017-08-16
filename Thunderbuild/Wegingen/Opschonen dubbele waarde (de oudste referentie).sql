DELETE FROM [DWH]..[qWegingen]
WHERE [Nr] in
(
select Min(Nr) as Nr
  FROM [DWH].[dbo].[qWegingen]
  group by Referentie, Begeleidingsbrief, Weegbon
HAVING 1=1
and count(*) > 1
and Referentie is not null
)