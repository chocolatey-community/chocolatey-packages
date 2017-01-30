$ErrorActionPreference = 'Stop';

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$installLocation = GetInstallLocation "$toolsPath\.."
# Backup the existing php config file
$cacheFile = "$env:TEMP\php\config.ini"

if (Test-Path "$installLocation\php.ini") {
  if (!(Test-Path "$env:TEMP\php")) {
    New-Item "$env:TEMP\php" -ItemType Directory
  }
  Write-Host "Backing up php configuration file."
  Copy-Item -Force -ea 0 "$installLocation\php.ini" $cacheFile
}

Uninstall-ChocolateyPath $installLocation
