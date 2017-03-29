<?xml version="1.0" encoding="ASCII"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:output method="xml" encoding="ASCII"/>
	<xsl:template match="/">
		<eExact>
			<xsl:attribute name="xsi:noNamespaceSchemaLocation">eExact-Schema.xsd</xsl:attribute>
			<xsl:for-each select="Quercis/Groep/Kop">
				<Project>
				
					<Projectcode>
						<xsl:value-of select="./projectcode"/>
					</Projectcode>
					<Omschrijving>
						<xsl:value-of select="./omschrijving"/>
					</Omschrijving>
					<Debcode>
						<xsl:value-of select="./debcode"/>
					</Debcode>
					<Debnaam>
						<xsl:value-of select="./debnaam"/>
					</Debnaam>
					<Status>
						<xsl:value-of select="./status"/>
					</Status>
				</Project>
			</xsl:for-each>
		</eExact>
	</xsl:template>
</xsl:stylesheet>