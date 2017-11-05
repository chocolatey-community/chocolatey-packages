$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

$pp = Import-Clixml $toolsDir\pp.xml
if (!$pp.NoPath)  { Uninstall-ChocolateyPath $pp.InstallDir } 

Write-Host "Please remove installdir manually when you don't need it anymore."
Write-Host "Install dir: " $pp.InstallDir