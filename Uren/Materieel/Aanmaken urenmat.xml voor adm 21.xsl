<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:output method="xml" encoding="UTF-8"/>
	<xsl:template match="/">
		<eExact xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="eExact-Schema.xsd">
			<GLEntries>
				<xsl:for-each select="Quercis/Groep">
					<GLEntry entry="" status="E">
						<Division code="021"/>
						<Journal code="98" type="M">
							<Description>Importmutaties</Description>
						</Journal>
						<xsl:for-each select="./Kop">
							<FinEntryLine type="N">
								<Date>
									<xsl:value-of select="./datum"/>
								</Date>
								<GLAccount>
									<xsl:attribute name="code">
										<xsl:value-of select="./reknr"/>
									</xsl:attribute>
								</GLAccount>
								<Description>
									<xsl:value-of select="./omschrijving"/>
								</Description>
								<Costcenter>
									<xsl:attribute name="code">
										<xsl:value-of select="./kpl"/>
									</xsl:attribute>
									<Description>
										<xsl:value-of select="./kploms"/>
									</Description>
								</Costcenter>
								<Costunit>
									<xsl:attribute name="code">
										<xsl:value-of select="./kstdr"/>
									</xsl:attribute>
								</Costunit>
								<Resource>
									<xsl:attribute name="number">
										<xsl:value-of select="./medew"/>
									</xsl:attribute>
								</Resource>
								<Item>
									<xsl:attribute name="code">
										<xsl:value-of select="./art"/>
									</xsl:attribute>
								</Item>
								<Project>
									<xsl:attribute name="code">
										<xsl:value-of select="./project"/>
									</xsl:attribute>
								</Project>
								<Amount>
									<Currency>
										<xsl:attribute name="code">
											<xsl:value-of select="./valcode" />
										</xsl:attribute>
									</Currency>
									<Debit>
										<xsl:value-of select="./bedrag"/>
									</Debit>
									<Credit>0.0</Credit>
									<VAT code="0" >
									</VAT>
								</Amount>
								<Quantity>
									<xsl:value-of select="./aantal"/>
								</Quantity>
								<FinReferences>
									<YourRef>
										<xsl:value-of select="./consref"/>
									</YourRef>
								</FinReferences>
								<FreeFields>
									<FreeTexts>
										<FreeText number="1">
											<xsl:value-of select="./Class_01"/>
										</FreeText>
										<FreeText number="2">
											<xsl:value-of select="./gewijzigd"/>
										</FreeText>
									</FreeTexts>
									<FreeNumbers>
										<FreeNumber number="5">
											<xsl:value-of select="./id"/>
										</FreeNumber>
									</FreeNumbers>
								</FreeFields>
							</FinEntryLine>
						</xsl:for-each>
					</GLEntry>
				</xsl:for-each>
			</GLEntries>
		</eExact>
	</xsl:template>
</xsl:stylesheet>