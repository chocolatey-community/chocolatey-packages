$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$filePath = "$toolsDir\autoit-v3.zip"

Get-ChocolateyUnzip -FileFullPath $filePath -Destination $toolsDir

# Lets remove the installer as there is no more need for it
Remove-Item -Force $filePath
