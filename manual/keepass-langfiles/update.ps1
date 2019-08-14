$ErrorActionPreference = "Stop"

$translation_page = Invoke-WebRequest "https://keepass.info/translations.html" -UseBasicParsing

$allTranstations = $translation_page.Links | ? href -match "https.*2\.\d+.*\.zip$" | % href

$tempExtraction = "$env:TEMP\keepass-langfiles"

if (Test-Path $tempExtraction) { rm -Recurse -Force $tempExtraction }

Import-Module "$Env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
"Downloading all translations..."
$allTranstations | % {
  $filename = $_ -split "\/" | select -Last 1
  Get-WebFile (Get-RedirectedUrl "$_") "$tempExtraction\$filename"
  Get-ChocolateyUnzip -FileFullPath "$tempExtraction\$filename" -Destination "$tempExtraction\languages"
}

"Creating new archive with languages..."
7z a -t7z "$PSScriptRoot\tools\keepass_2.x_langfiles.7z" -m0=lzma2 -mx=9 -aoa "$tempExtraction\languages\*.lngx"
