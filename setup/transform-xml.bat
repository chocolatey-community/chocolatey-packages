@echo off

where transform 1>nul 2>&1 || (
	echo Transform.exe not found on PATH. Please install Saxon Home Edition, e.g. by running
	echo choco install saxonhe
	exit /b 1
)

transform -s:"%~1" -xsl:"%~2"
