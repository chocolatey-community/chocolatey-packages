<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xsl:output indent="yes" cdata-section-elements="SourceTemplate"/>
	<xsl:template match="/Jobs">
		<xsl:for-each select="ApplicationJob">
			<xsl:result-document method="xml" href="automatic/{Name}/{Name}.ketarin.xml">
				<Jobs>
					<xsl:copy-of select="." />
				</Jobs>
			</xsl:result-document>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
