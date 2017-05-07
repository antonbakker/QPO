drop table QSagroSoftUren
-- adm 546 niet aanwezig
delete from Q_idcontrole_u
insert into Q_idcontrole_u
select * from
(
select distinct  freefield5  from [512]..gbkmut
where dagbknr =' 98' and project is not null and reknr ='     5910' and transtype  not in( 'V')

union all

select distinct  freefield5  from [521]..gbkmut
where dagbknr =' 98' and project is not null and reknr ='     5910' and transtype  not in( 'V')

union all

select distinct  freefield5  from [522]..gbkmut
where dagbknr =' 98' and project is not null and reknr ='     5910' and transtype  not in( 'V')

union all

select distinct freefield5 from [523]..gbkmut
where dagbknr =' 98' and project is not null and reknr ='     5910' and transtype  not in( 'V')

union all

select distinct freefield5  from [524]..gbkmut
where dagbknr =' 98' and project is not null and reknr ='     5910' and transtype  not in( 'V')

union all

select distinct  freefield5 from [525]..gbkmut
where dagbknr =' 98' and project is not null and reknr ='     5910' and transtype  not in( 'V')

union all

select distinct  freefield5  from [527]..gbkmut
where dagbknr =' 98' and project is not null and reknr ='     5910' and transtype  not in( 'V')

union all

select distinct freefield5  from [528]..gbkmut
where dagbknr =' 98' and project is not null and reknr ='     5910' and transtype  not in( 'V')

union all

select distinct freefield5  from [541]..gbkmut
where dagbknr =' 98' and project is not null and reknr ='     5910' and transtype  not in( 'V')

union all

select distinct freefield5 from [542]..gbkmut
where dagbknr =' 98' and project is not null and reknr ='     5910' and transtype  not in( 'V')

union all

select distinct freefield5 from [543]..gbkmut
where dagbknr =' 98' and project is not null and reknr ='     5910' and transtype  not in( 'V')

union all

select distinct freefield5 from [547]..gbkmut
where dagbknr =' 98' and project is not null and reknr ='     5910' and transtype  not in( 'V')

union all

select distinct  freefield5  from [561]..gbkmut
where dagbknr =' 98' and project is not null and reknr ='     5910' and transtype  not in( 'V')
--union all
--Select distinct freefield5 from [546]..gbkmut
--where dagbknr =' 98' and project is not null and reknr ='     5910' and transtype  not in( 'V')
)

as x
