<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
	<xsl:output indent="yes" cdata-section-elements="SourceTemplate"/>
	<xsl:template match="/Jobs/ApplicationJob">
		<xsl:result-document method="xml" href="{Name}.ketarin-fixed.xml">
			<Jobs>
				<ApplicationJob xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
					<xsl:for-each select="@*">
						<xsl:attribute name="{name(.)}"><xsl:value-of select="."/></xsl:attribute>
					</xsl:for-each>
					<xsl:copy-of select="SourceTemplate" />
					<WebsiteUrl />
					<UserAgent />
					<UserNotes />
					<xsl:copy-of select="LastFileSize" />
					<xsl:copy-of select="LastFileDate" />
					<IgnoreFileInformation>false</IgnoreFileInformation>
					<DownloadBeta>Default</DownloadBeta>
					<DownloadDate xsi:nil="true" />
					<CheckForUpdatesOnly>false</CheckForUpdatesOnly>
					<VariableChangeIndicator />
					<CanBeShared>true</CanBeShared>
					<ShareApplication>false</ShareApplication>
					<ExclusiveDownload>false</ExclusiveDownload>
					<HttpReferer />
					<SetupInstructions />
					<xsl:copy-of select="Variables" />
					<ExecuteCommand />
					<ExecutePreCommand />
					<ExecuteCommandType>Batch</ExecuteCommandType>
					<ExecutePreCommandType>Batch</ExecutePreCommandType>
					<Category />
					<SourceType>FixedUrl</SourceType>
					<PreviousLocation />
					<DeletePreviousFile>true</DeletePreviousFile>
					<Enabled>true</Enabled>
					<FileHippoId />
					<xsl:copy-of select="LastUpdated" />
					<TargetPath>C:\Chocolatey\_work\</TargetPath>
					<xsl:copy-of select="FixedDownloadUrl" />
					<xsl:copy-of select="Name" />
				</ApplicationJob>
			</Jobs>
		</xsl:result-document>
	</xsl:template>
</xsl:stylesheet>
