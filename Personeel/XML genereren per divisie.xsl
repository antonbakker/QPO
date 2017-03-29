<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"     xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" />
<xsl:template match="/">
	<eExact xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="eExact-Schema.xsd">
		<xsl:for-each select="Quercis/Kop">
			<Resources>
				<xsl:for-each select="./Regel">
					<Resource>
						
						<xsl:attribute name="number">
							<xsl:value-of select="./ResourceNumber" />
						</xsl:attribute>
						
						<xsl:attribute name="code">
							<xsl:value-of select="./ResourceInlogcode" />
						</xsl:attribute>
						
						<xsl:attribute name="type">
							<xsl:value-of select="./ResourceType" />
						</xsl:attribute>
						
						<xsl:attribute name="status">
							<xsl:value-of select="./ResourceStatus" />
						</xsl:attribute>
						
						<xsl:attribute name="gender">
							<xsl:value-of select="./ResourceGeslacht" />
						</xsl:attribute>
						
						<MiddleName>
							<xsl:value-of select="./ResourceTussenvoegsel" />
						</MiddleName>
						
						<LastName>
							<xsl:value-of select="./ResourceAchternaam" />
						</LastName>
						
						<FirstName>
							<xsl:value-of select="./ResourceVoornaam" />
						</FirstName>
						
						<Initials>
							<xsl:value-of select="./ResourceInitialen" />
						</Initials>
						
						<Organization>
							<Division>
								<xsl:attribute name="code">
									<xsl:value-of select="./OrganisatieDivisie" />
								</xsl:attribute>
							</Division>
							<Costcenter>
								<xsl:attribute name="code">
									<xsl:value-of select="./ResourceCostCenter" />
								</xsl:attribute>
							</Costcenter>
						</Organization>
						
						<Banking>
							<SocialSecurity>
								<xsl:value-of select="./ResourceSofinummer" />
							</SocialSecurity>
						</Banking>

					</Resource>
				</xsl:for-each>
			</Resources>
		</xsl:for-each>
	</eExact>
</xsl:template>
</xsl:stylesheet>
