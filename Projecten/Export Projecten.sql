select * from

(SELECT     [561].dbo.PRProject.ProjectNr COLLATE DATABASE_default AS projectcode, [561].dbo.PRProject.Description COLLATE DATABASE_default AS omschrijving, 
                      [561].dbo.cicmpy.debcode COLLATE DATABASE_default AS debcode, [561].dbo.cicmpy.cmp_name COLLATE DATABASE_default AS debnaam, 
                      [561].dbo.PRProject.Status COLLATE DATABASE_default AS status, [561].dbo.PRProject.sysmodified
FROM         [561].dbo.PRProject LEFT OUTER JOIN
                      [561].dbo.cicmpy ON [561].dbo.PRProject.IDCustomer = [561].dbo.cicmpy.cmp_wwn
WHERE     ([561].dbo.PRProject.Status <> 'P')
UNION ALL
SELECT     [521].dbo.PRProject.ProjectNr, [521].dbo.PRProject.Description, [521].dbo.cicmpy.debcode, [521].dbo.cicmpy.cmp_name, [521].dbo.PRProject.Status, 
                      [521].dbo.PRProject.sysmodified
FROM         [521].dbo.PRProject LEFT OUTER JOIN
                      [521].dbo.cicmpy ON [521].dbo.PRProject.IDCustomer = [521].dbo.cicmpy.cmp_wwn
WHERE     ([521].dbo.PRProject.Status <> 'P')

UNION ALL
SELECT     [527].dbo.PRProject.ProjectNr, [527].dbo.PRProject.Description, [527].dbo.cicmpy.debcode, [527].dbo.cicmpy.cmp_name, [527].dbo.PRProject.Status, 
                      [527].dbo.PRProject.sysmodified
FROM         [527].dbo.PRProject LEFT OUTER JOIN
                      [527].dbo.cicmpy ON [527].dbo.PRProject.IDCustomer = [527].dbo.cicmpy.cmp_wwn
WHERE     ([527].dbo.PRProject.Status <> 'P')
UNION ALL

SELECT     [541].dbo.PRProject.ProjectNr, [541].dbo.PRProject.Description, [541].dbo.cicmpy.debcode, [541].dbo.cicmpy.cmp_name, [541].dbo.PRProject.Status, 
                      [541].dbo.PRProject.sysmodified
FROM         [541].dbo.PRProject LEFT OUTER JOIN
                      [541].dbo.cicmpy ON [541].dbo.PRProject.IDCustomer = [541].dbo.cicmpy.cmp_wwn
WHERE     ([541].dbo.PRProject.Status <> 'P')
UNION ALL
SELECT     [523].dbo.PRProject.ProjectNr, [523].dbo.PRProject.Description, [523].dbo.cicmpy.debcode, [523].dbo.cicmpy.cmp_name, [523].dbo.PRProject.Status, 
                      [523].dbo.PRProject.sysmodified
FROM         [523].dbo.PRProject LEFT OUTER JOIN
                      [523].dbo.cicmpy ON [523].dbo.PRProject.IDCustomer = [523].dbo.cicmpy.cmp_wwn
WHERE     ([523].dbo.PRProject.Status <> 'P')
UNION ALL
SELECT     [524].dbo.PRProject.ProjectNr, [524].dbo.PRProject.Description, [524].dbo.cicmpy.debcode, [524].dbo.cicmpy.cmp_name, [524].dbo.PRProject.Status, 
                      [524].dbo.PRProject.sysmodified
FROM         [524].dbo.PRProject LEFT OUTER JOIN
                      [524].dbo.cicmpy ON [524].dbo.PRProject.IDCustomer = [524].dbo.cicmpy.cmp_wwn
WHERE     ([524].dbo.PRProject.Status <> 'P')
UNION ALL
SELECT     [522].dbo.PRProject.ProjectNr, [522].dbo.PRProject.Description, [522].dbo.cicmpy.debcode, [522].dbo.cicmpy.cmp_name, [522].dbo.PRProject.Status, 
                      [522].dbo.PRProject.sysmodified
FROM         [522].dbo.PRProject LEFT OUTER JOIN
                      [522].dbo.cicmpy ON [522].dbo.PRProject.IDCustomer = [522].dbo.cicmpy.cmp_wwn
WHERE     ([522].dbo.PRProject.Status <> 'P')
UNION ALL
SELECT     [525].dbo.PRProject.ProjectNr, [525].dbo.PRProject.Description, [525].dbo.cicmpy.debcode, [525].dbo.cicmpy.cmp_name, [525].dbo.PRProject.Status, 
                      [525].dbo.PRProject.sysmodified
FROM         [525].dbo.PRProject LEFT OUTER JOIN
                      [525].dbo.cicmpy ON [525].dbo.PRProject.IDCustomer = [525].dbo.cicmpy.cmp_wwn
WHERE     ([525].dbo.PRProject.Status <> 'P')

UNION ALL
SELECT     [543].dbo.PRProject.ProjectNr, [543].dbo.PRProject.Description, [543].dbo.cicmpy.debcode, [543].dbo.cicmpy.cmp_name, [543].dbo.PRProject.Status, 
                      [543].dbo.PRProject.sysmodified
FROM         [543].dbo.PRProject LEFT OUTER JOIN
                      [543].dbo.cicmpy ON [543].dbo.PRProject.IDCustomer = [543].dbo.cicmpy.cmp_wwn
WHERE     ([543].dbo.PRProject.Status <> 'P')
UNION ALL
SELECT     [512].dbo.PRProject.ProjectNr, [512].dbo.PRProject.Description, [512].dbo.cicmpy.debcode, [512].dbo.cicmpy.cmp_name, [512].dbo.PRProject.Status, 
                      [512].dbo.PRProject.sysmodified
FROM         [512].dbo.PRProject LEFT OUTER JOIN
                      [512].dbo.cicmpy ON [512].dbo.PRProject.IDCustomer = [512].dbo.cicmpy.cmp_wwn
WHERE     ([512].dbo.PRProject.Status <> 'P')

union all
SELECT     [528].dbo.PRProject.ProjectNr, [528].dbo.PRProject.Description, [528].dbo.cicmpy.debcode, [528].dbo.cicmpy.cmp_name, [528].dbo.PRProject.Status, 
                      [528].dbo.PRProject.sysmodified
FROM         [528].dbo.PRProject LEFT OUTER JOIN
                      [528].dbo.cicmpy ON [528].dbo.PRProject.IDCustomer = [528].dbo.cicmpy.cmp_wwn
WHERE     ([528].dbo.PRProject.Status <> 'P')

union all
SELECT     [547].dbo.PRProject.ProjectNr, [547].dbo.PRProject.Description, [547].dbo.cicmpy.debcode, [547].dbo.cicmpy.cmp_name, [547].dbo.PRProject.Status, 
                      [547].dbo.PRProject.sysmodified
FROM         [547].dbo.PRProject LEFT OUTER JOIN
                      [547].dbo.cicmpy ON [547].dbo.PRProject.IDCustomer = [547].dbo.cicmpy.cmp_wwn
WHERE     ([547].dbo.PRProject.Status <> 'P')

)as projectexact



 WHERE     Isnull (projectexact.sysmodified,1) >(select MAX(exportdatum) from QSagroSoftProject)

order by sysmodified desc