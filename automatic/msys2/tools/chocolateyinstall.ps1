$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath/helpers.ps1

Install-Msys2
Set-Msys2Proxy 
Invoke-Msys2ShellFirstRun
Update-Msys2

if (!$pp.NoPath) { Install-ChocolateyPath $pp.InstallDir }