﻿$ErrorActionPreference = 'Stop'

foreach ($process in (Get-Process "$env:ChocolateyPackageName*" -ErrorAction SilentlyContinue)) {
   Stop-Process -Name $process.ProcessName -Force
}

$packageName     = 'tixati'
$installLocation = Get-AppInstallLocation $packageName
$uninstaller     = "$installLocation\uninstall.exe"
if (!(Test-Path $uninstaller)) { Write-Warning "$packageName has already been uninstalled by other means."; return }

$packageArgs = @{
    packageName            = $packageName
    silentArgs             = "/S"
    fileType               = 'EXE'
    validExitCodes         = @(0,10)
    file                   = $uninstaller
}
Uninstall-ChocolateyPackage @packageArgs
