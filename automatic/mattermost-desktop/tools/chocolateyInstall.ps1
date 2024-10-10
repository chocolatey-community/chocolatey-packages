$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName            = 'mattermost-desktop'
  fileType               = 'msi'
  file                   = "$toolsDir\mattermost-desktop-5.9.0-win-arm64.msi"
  file64                 = "$toolsDir\mattermost-desktop-5.9.0-win-x64.msi"
  checksum               = '2A13566E780CCAED7A944C974AE547E7B045D2A4D25602740D210AECE3F028C8'
  checksum64             = '2E8592BC18E1AA18A59365547135778FE462A76549ECC4A8FA005452F74BF162'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes         = @(0, 3010, 1641)
  softwareName           = 'Mattermost*'
}

Install-ChocolateyInstallPackage @packageArgs

# Lets remove the installer and ignore files as there is no more need for them
Get-ChildItem $toolsDir\*.msi | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
