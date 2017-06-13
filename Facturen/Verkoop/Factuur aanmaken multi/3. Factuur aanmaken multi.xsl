<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<xsl:output method="xml" encoding="UTF-8"/>
	<xsl:template match="/">
		<eExact xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="eExact-Schema.xsd">
			<Invoices>
				<xsl:for-each select="Quercis/Kop">
					<Invoice type="V" code="00">
						<Description>
							<xsl:value-of select="./uwref"/>
						</Description>
						<YourRef>
							<xsl:value-of select="./uwref"/>
						</YourRef>
						<Currency code="EUR" />
						<CalcIncludeVAT>N</CalcIncludeVAT>
						<Resource number="1" code="">
						</Resource>
						<OrderedBy>
							<Debtor>
								<xsl:attribute name="code">
									<xsl:value-of select="./debnr"/>
								</xsl:attribute>
							</Debtor>
						</OrderedBy>
						<DeliverTo>
							<Debtor>
								<xsl:attribute name="code">
									<xsl:value-of select="./debnr"/>
								</xsl:attribute>
							</Debtor>
						</DeliverTo>
						<InvoiceTo>
							<Debtor>
								<xsl:attribute name="code">
									<xsl:value-of select="./debnr"/>
								</xsl:attribute>
							</Debtor>
						</InvoiceTo>
						<Warehouse code="1">
						</Warehouse>
						<InvoiceGroup code="">
						</InvoiceGroup>
						<FreeFields>
							<FreeTexts>
								<FreeText number="1">
									<xsl:value-of select="./groepering"/>
								</FreeText>
							</FreeTexts>
						</FreeFields>
						<InvoiceLine>
							<LineYourRef>
								<xsl:value-of select="./yourref"/>
							</LineYourRef>
							<Text>
								<xsl:value-of select="./tekstregel"/>
							</Text>
						</InvoiceLine>
						<xsl:for-each select="./Regel">
							<InvoiceLine>
								<LineYourRef>
									<xsl:value-of select="./yourref"/>
								</LineYourRef>
								<Description>
									<xsl:value-of select="./Xomschrijving"/>
								</Description>
								<Item>
									<xsl:attribute name="code">
										<xsl:value-of select="./itemcode"/>
									</xsl:attribute>
								</Item>
								<Quantity>
									<xsl:value-of select="./aantal"/>
								</Quantity>
								<Price type="S">
									<Currency code="EUR" />
									<Value>
										<xsl:value-of select="./prijs"/>
									</Value>
								</Price>
								<Amount type="S">
									<Currency code="EUR" />
									<Value>
										<xsl:value-of select="./bedrag"/>
									</Value>
								</Amount>
								<VAT>
									<xsl:attribute name="code">
										<xsl:value-of select="./btwcode"/>
									</xsl:attribute>
								</VAT>
								<Delivery>
									<Date>
										<xsl:value-of select="./datum"/>
									</Date>
								</Delivery>
								<Warehouse code="1" />
								<Project>
									<xsl:attribute name="code">
										<xsl:value-of select="./projectcode"/>
									</xsl:attribute>
								</Project>
								<Resource>
									<xsl:attribute name="code">
										<xsl:value-of select="./res_id"/>
									</xsl:attribute>
								</Resource>
								<Text>
									<xsl:value-of select="./omschrijving"/>
								</Text>
							</InvoiceLine>
						</xsl:for-each>
					</Invoice>
				</xsl:for-each>
			</Invoices>
		</eExact>
	</xsl:template>
</xsl:stylesheet>
