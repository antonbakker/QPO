<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
<xsl:output method="xml" encoding="UTF-8" />
<xsl:template match="/">
	<eExact xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="eExact-Schema.xsd">
		<GLEntries>
			<xsl:for-each select="Quercis/Kop">
				<GLEntry entry="" status="E">
					<Date>
						<Value>
							<xsl:value-of select="./Kdatum" />
						</Value>
					</Date>
					<DocumentDate>
						<Value>
							<xsl:value-of select="./Kdocdate" />
						</Value>
					</DocumentDate>
					<Journal code="50" type="I">
					</Journal>
					<Description>
						<Value>
							<xsl:value-of select="./description" />
						</Value>
					</Description>
						<FreeFields>
								<FreeTexts>
									<FreeText number="1">
										<xsl:value-of select="./yourref"/>
									</FreeText>
									<FreeText number="3">
										<xsl:value-of select="./xx"/>
									</FreeText>
								</FreeTexts>
								<FreeNumbers>
									<FreeNumber number="4">
										<xsl:value-of select="./fiat"/>
									</FreeNumber>
								</FreeNumbers>
							</FreeFields>
					<xsl:for-each select="./Regel">
						<FinEntryLine>
							<GLAccount>
								<xsl:attribute name="code">
									<xsl:value-of select="./r_reknr" />
								</xsl:attribute>
							</GLAccount>
							<Costunit>
								<xsl:attribute name="code">
									<xsl:value-of select="./kstdr" />
								</xsl:attribute>
							</Costunit>
							<Creditor>
								<xsl:attribute name="code">
									<xsl:value-of select="./crediteur" />
								</xsl:attribute>
							</Creditor>
							<Description>
								<Value>
									<xsl:value-of select="./oms25" />
								</Value>
							</Description>
							<Resource>
								<xsl:attribute name="number">
									<xsl:value-of select="./r_resid" />
								</xsl:attribute>
							</Resource>
							<Item>
								<xsl:attribute name="code">
									<xsl:value-of select="./r_itemcode" />
								</xsl:attribute>
							</Item>
							<Project>
								<xsl:attribute name="code">
									<xsl:value-of select="./r_projectnr" />
								</xsl:attribute>
							</Project>
							<Date>
								<Value>
									<xsl:value-of select="./Rdatum" />
								</Value>
							</Date>
							<Quantity>
								<Value>
									<xsl:value-of select="./r_aantal" />
								</Value>
							</Quantity>
							<Amount>
								<Currency code="EUR" />
								<Debit>
									<xsl:value-of select="./bedrag" />
								</Debit>
								<Credit>0</Credit>
								<VAT>
									<xsl:attribute name="code">
										<xsl:value-of select="./btwcode" />
									</xsl:attribute>
								</VAT>
							</Amount>
							<Payment>
								<InvoiceNumber>
								</InvoiceNumber>
							</Payment>
							<FinReferences TransactionOrigin="N">
								<YourRef>
									<xsl:value-of select="./faktuurnr" />
								</YourRef>
								<DocumentDate>
									<Value>
										<xsl:value-of select="./Rdocdate" />
									</Value>
								</DocumentDate>
							</FinReferences>
							<FreeFields>
								<FreeTexts>
									<FreeText number="1">
										<xsl:value-of select="./yourref"/>
									</FreeText>
									<FreeText number="3">
										<xsl:value-of select="./soort"/>
									</FreeText>
								</FreeTexts>
								<FreeNumbers>
									<FreeNumber number="4">
										<xsl:value-of select="./fiat"/>
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