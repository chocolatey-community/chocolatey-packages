﻿$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    softwareName   = 'Git Extensions*'
    fileType       = 'msi'
    file           = "$toolsDir\GitExtensions-x64-5.0.0.17897-2a3b78b86.msi"
    silentArgs     = '/quiet /norestart ADDDEFAULT=ALL REMOVE=AddToPath'
    validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs

Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }

Install-BinFile gitex "$(Get-AppInstallLocation GitExtensions)\gitex.cmd"
