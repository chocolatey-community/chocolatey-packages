﻿$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName            = 'mattermost-desktop'
  fileType               = 'msi'
  file                   = "$toolsDir\mattermost-desktop-5.0.2-x86.msi"
  file64                 = "$toolsDir\mattermost-desktop-5.0.2-x64.msi"
  checksum               = 'CBF125CAEE0ED4974D529AEF06C712FA13928904024C30043B90C866D51F3338'
  checksum64             = '5CFB108EC4C1E724A0065FFAA23666A359C658EC9A25E0BACCFB27AAE44425FE'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes         = @(0, 3010, 1641)
  softwareName           = 'Mattermost*'
}

Install-ChocolateyInstallPackage @packageArgs

# Lets remove the installer and ignore files as there is no more need for them
Get-ChildItem $toolsDir\*.msi | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
