drop table QSagroSoftUrenOH

delete from Q_idcontrole_oh
insert into Q_idcontrole_oh
select * from 
(
select distinct freefield5 from [512]..gbkmut
where dagbknr =' 98'  and reknr in ('     4400','     4450','     4813') and transtype  not in( 'V')

UNION all

select distinct  freefield5  from [521]..gbkmut
where dagbknr =' 98' and reknr in ('     4400','     4450','     4813') and transtype  not in( 'V')

union all

select distinct  freefield5  from [522]..gbkmut
where dagbknr =' 98'  and reknr in ('     4400','     4450','     4813') and transtype  not in( 'V')

union all

select distinct freefield5 from [523]..gbkmut
where dagbknr =' 98'  and reknr in ('     4400','     4450','     4813') and transtype  not in( 'V')

union all

select distinct freefield5  from [524]..gbkmut
where dagbknr =' 98' and reknr in ('     4400','     4450','     4813') and transtype  not in( 'V')

union all

select distinct  freefield5 from [525]..gbkmut
where dagbknr =' 98'  and reknr in ('     4400','     4450','     4813') and transtype  not in( 'V')

union all

select distinct  freefield5  from [527]..gbkmut
where dagbknr =' 98' and reknr in ('     4400','     4450','     4813') and transtype  not in( 'V')

union all

select distinct freefield5  from [528]..gbkmut
where dagbknr =' 98'  and reknr in ('     4400','     4450','     4813') and transtype  not in( 'V')

union all

select distinct freefield5  from [541]..gbkmut
where dagbknr =' 98' and  reknr in ('     4400','     4450','     4813') and transtype  not in( 'V')

union all

select distinct freefield5  from [542]..gbkmut
where dagbknr =' 98' and  reknr in ('     4400','     4450','     4813') and transtype  not in( 'V')

union all

select distinct freefield5 from [543]..gbkmut
where dagbknr =' 98'  and reknr in ('     4400','     4450','     4813') and transtype  not in( 'V')

union all

select distinct freefield5 from [547]..gbkmut
where dagbknr =' 98'  and reknr in ('     4400','     4450','     4813') and transtype  not in( 'V')

union all

select distinct  freefield5  from [561]..gbkmut
where dagbknr =' 98' and reknr in ('     4400','     4450','     4813') and transtype  not in( 'V')
)

as x
