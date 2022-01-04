﻿$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  file           = "$toolsDir\peazip-8.4.0.WINDOWS.exe"
  file64         = "$toolsDir\peazip-8.4.0.WIN64.exe"
  fileType       = 'exe'
  packageName    = 'peazip.install'
  softwareName   = 'PeaZip'
  silentArgs     = "/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).Install.log`""
  validExitCodes = @(0, 1223)
}

Install-ChocolateyInstallPackage @packageArgs

Get-ChildItem -Path $toolsDir\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
