<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sepa="urn:iso:std:iso:20022:tech:xsd:pain.008.001.02">
	<xsl:output method="text" indent="no"/>
	<xsl:param name="espacios">                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          '</xsl:param>
	<xsl:param name="ceros">00000000000000000000000000000000000000000000</xsl:param>
	<xsl:template match="sepa:Document">
		<xsl:for-each select="sepa:CstmrDrctDbtInitn">
			<!-- Cabecera del presentador -->
			<xsl:text>01</xsl:text>
			<xsl:text>19143</xsl:text>
			<xsl:text>001</xsl:text>
			<xsl:value-of select="concat(sepa:PmtInf/sepa:CdtrSchmeId/sepa:Id/sepa:PrvtId/sepa:Othr/sepa:Id, substring($espacios, 1, 35 - string-length(sepa:PmtInf/sepa:CdtrSchmeId/sepa:Id/sepa:PrvtId/sepa:Othr/sepa:Id)))"/>
			<xsl:value-of select="concat(sepa:PmtInf/sepa:Cdtr/sepa:Nm, substring($espacios, 1, 70 - string-length(sepa:PmtInf/sepa:Cdtr/sepa:Nm)))"/>
			<xsl:variable name="dt" select="sepa:GrpHdr/sepa:CreDtTm"/>
			<xsl:value-of select="concat(substring($dt, 1, 4), substring($dt, 6, 2), substring($dt, 9, 2))"/>
			<xsl:text>PRE</xsl:text>
			<xsl:value-of select="concat(substring($dt, 1, 4), substring($dt, 6, 2), substring($dt, 9, 2))"/>
			<xsl:value-of select="concat(substring($dt, 12, 2), substring($dt, 15, 2), substring($dt, 18, 2))"/>
			<xsl:text>00234</xsl:text><!-- milisegundos -->
			<xsl:variable name="id_fichero" select="concat(sepa:GrpHdr/sepa:MsgId, substring($espacios, 1, 13))"/> 
			<xsl:value-of select="substring($id_fichero, 1, 13)"/>
			<xsl:value-of select="substring(sepa:PmtInf/sepa:CdtrAcct/sepa:Id/sepa:IBAN, 5, 8)"/>
			<xsl:value-of select="substring($espacios, 1, 434)"/>
			<xsl:text>&#xA;</xsl:text>
			<xsl:for-each select="sepa:PmtInf">
				<!-- Cabecera de acreedor -->
				<xsl:text>02</xsl:text>
				<xsl:text>19143</xsl:text>
				<xsl:text>002</xsl:text>
				<xsl:value-of select="concat(sepa:CdtrSchmeId/sepa:Id/sepa:PrvtId/sepa:Othr/sepa:Id, substring($espacios, 1, 35 - string-length(sepa:CdtrSchmeId/sepa:Id/sepa:PrvtId/sepa:Othr/sepa:Id)))"/>
				<xsl:value-of select="concat(substring(sepa:ReqdColltnDt, 1, 4), substring(sepa:ReqdColltnDt, 6, 2), substring(sepa:ReqdColltnDt, 9, 2))"/>
				<xsl:value-of select="concat(sepa:Cdtr/sepa:Nm, substring($espacios, 1, 70 - string-length(sepa:Cdtr/sepa:Nm)))"/>
				<xsl:value-of select="substring($espacios, 1, 140)"/>
				<xsl:text>ES</xsl:text>
				<xsl:value-of select="concat(sepa:CdtrAcct/sepa:Id/sepa:IBAN, substring($espacios, 1, 34 - string-length(sepa:CdtrAcct/sepa:Id/sepa:IBAN)))"/>
				<xsl:value-of select="substring($espacios, 1, 301)"/>
				<xsl:text>&#xA;</xsl:text>
				<xsl:for-each select="sepa:DrctDbtTxInf">
					<!-- Registros individuales -->
					<xsl:text>03</xsl:text>
					<xsl:text>19143</xsl:text>
					<xsl:text>003</xsl:text>
					<xsl:value-of select="concat(sepa:PmtId/sepa:EndToEndId, substring($espacios, 1, 35 - string-length(sepa:PmtId/sepa:EndToEndId)))"/>
					<xsl:value-of select="concat(sepa:DrctDbtTx/sepa:MndtRltdInf/sepa:MndtId, substring($espacios, 1, 35 - string-length(sepa:DrctDbtTx/sepa:MndtRltdInf/sepa:MndtId)))"/>
					<xsl:text>RCUR</xsl:text>
					<xsl:text>    </xsl:text>
					<xsl:variable name="importe" select="concat(substring(sepa:InstdAmt, 1, string-length(sepa:InstdAmt) - 3), substring(sepa:InstdAmt, string-length(sepa:InstdAmt) - 1))"/>
					<xsl:value-of select="concat(substring($ceros, 1, 11 - string-length($importe)), $importe)"/>
					<xsl:variable name="dt2" select="sepa:DrctDbtTx/sepa:MndtRltdInf/sepa:DtOfSgntr"/>
					<xsl:value-of select="concat(substring($dt2, 1, 4), substring($dt2, 6, 2), substring($dt2, 9, 2))"/>
					<xsl:value-of select="sepa:DbtrAgt/sepa:FinInstnId/sepa:BIC"/>
					<xsl:value-of select="concat(translate(translate(sepa:Dbtr/sepa:Nm, 'Ñ', 'N'), 'Ç', 'C'), substring($espacios, 1, 70 - string-length(sepa:Dbtr/sepa:Nm)))"/>
					<xsl:value-of select="substring($espacios, 1, 142)"/>
					<xsl:text>1</xsl:text>
					<xsl:value-of select="substring($espacios, 1, 71)"/>
					<xsl:text>A</xsl:text>
					<xsl:value-of select="concat(sepa:DbtrAcct/sepa:Id/sepa:IBAN, substring($espacios, 1, 34 - string-length(sepa:DbtrAcct/sepa:Id/sepa:IBAN)))"/>
					<xsl:text>    </xsl:text>
					<xsl:value-of select="concat(sepa:RmtInf/sepa:Ustrd, substring($espacios, 1, 140 - string-length(sepa:RmtInf/sepa:Ustrd)))"/>
					<xsl:value-of select="substring($espacios, 1, 19)"/>
					<xsl:text>&#xA;</xsl:text>
				</xsl:for-each>
				<!-- Total acreedor/fecha -->
				<xsl:text>04</xsl:text>
				<xsl:value-of select="concat(sepa:CdtrSchmeId/sepa:Id/sepa:PrvtId/sepa:Othr/sepa:Id, substring($espacios, 1, 35 - string-length(sepa:CdtrSchmeId/sepa:Id/sepa:PrvtId/sepa:Othr/sepa:Id)))"/>
				<xsl:value-of select="concat(substring(sepa:ReqdColltnDt, 1, 4), substring(sepa:ReqdColltnDt, 6, 2), substring(sepa:ReqdColltnDt, 9, 2))"/>
				<xsl:variable name="imp_acreedor_f" select="concat(substring(sepa:CtrlSum, 1, string-length(sepa:CtrlSum) - 3), substring(sepa:CtrlSum, string-length(sepa:CtrlSum) - 1))"/>
				<xsl:value-of select="concat(substring($ceros, 1, 17 - string-length($imp_acreedor_f)), $imp_acreedor_f)"/>
				<xsl:value-of select="concat(substring($ceros, 1, 8 - string-length(sepa:NbOfTxs)), sepa:NbOfTxs)"/>
				<xsl:value-of select="concat(substring($ceros, 1, 10 - string-length(sepa:NbOfTxs + 2)), sepa:NbOfTxs + 2)"/>
				<xsl:value-of select="substring($espacios, 1, 520)"/>
				<xsl:text>&#xA;</xsl:text>
				<!-- Total acreedor -->
				<xsl:text>05</xsl:text>
				<xsl:value-of select="concat(sepa:CdtrSchmeId/sepa:Id/sepa:PrvtId/sepa:Othr/sepa:Id, substring($espacios, 1, 35 - string-length(sepa:CdtrSchmeId/sepa:Id/sepa:PrvtId/sepa:Othr/sepa:Id)))"/>
				<xsl:variable name="imp_acreedor" select="concat(substring(sepa:CtrlSum, 1, string-length(sepa:CtrlSum) - 3), substring(sepa:CtrlSum, string-length(sepa:CtrlSum) - 1))"/>
				<xsl:value-of select="concat(substring($ceros, 1, 17 - string-length($imp_acreedor)), $imp_acreedor)"/>
				<xsl:value-of select="concat(substring($ceros, 1, 8 - string-length(sepa:NbOfTxs)), sepa:NbOfTxs)"/>
				<xsl:value-of select="concat(substring($ceros, 1, 10 - string-length(sepa:NbOfTxs + 3)), sepa:NbOfTxs + 3)"/>
				<xsl:value-of select="substring($espacios, 1, 528)"/>
				<xsl:text>&#xA;</xsl:text>
			</xsl:for-each>
			<!-- Total fichero -->
			<xsl:text>99</xsl:text>
			<xsl:variable name="imp_total" select="concat(substring(sepa:GrpHdr/sepa:CtrlSum, 1, string-length(sepa:GrpHdr/sepa:CtrlSum) - 3), substring(sepa:GrpHdr/sepa:CtrlSum, string-length(sepa:GrpHdr/sepa:CtrlSum) - 1))"/>
			<xsl:value-of select="concat(substring($ceros, 1, 17 - string-length($imp_total)), $imp_total)"/>
			<xsl:value-of select="concat(substring($ceros, 1, 8 - string-length(sepa:GrpHdr/sepa:NbOfTxs)), sepa:GrpHdr/sepa:NbOfTxs)"/>
			<xsl:value-of select="concat(substring($ceros, 1, 10 - string-length(sepa:GrpHdr/sepa:NbOfTxs + 5)), sepa:GrpHdr/sepa:NbOfTxs + 5)"/>
			<xsl:value-of select="substring($espacios, 1, 563)"/>
			<xsl:text>&#xA;</xsl:text>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
