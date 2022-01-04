﻿$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

. $toolsDir\chocolateyUninstall.ps1

$silentArgs = @('/S')

$packageArgs = @{
  packageName    = 'avidemux'
  fileType       = 'exe'
  file64         = "$toolsDir\Avidemux_2.8.0%20VC%2B%2B%2064bits%20.exe"
  silentArgs     = $silentArgs
  validExitCodes = @(0, 1223)
}

if ((Get-OSArchitectureWidth 64) -and ($env:chocolateyForceX86 -ne $true)) {
  $packageArgs.silentArgs = "--script $toolsDir\avidemux.qs"
}

Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*.exe

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if ($installLocation)  {
    Write-Host "$packageName installed to '$installLocation'"
    Register-Application "$installLocation\$packageName.exe"
    Write-Host "$packageName registered as $packageName"
}
else { Write-Warning "Can't find $PackageName install location" }
