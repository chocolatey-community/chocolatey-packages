$ErrorActionPreference = 'Stop'

$packageName     = 'tixati'
$installLocation = Get-AppInstallLocation $packageName
$uninstaller     = "$installLocation\uninstall.exe"
if (!(Test-Path $uninstaller)) { Write-Warning "$packageName has already been uninstalled by other means."; return }

start $uninstaller -ArgumentList '/s' -Wait
