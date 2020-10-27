$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName            = 'mattermost-desktop'
  fileType               = 'msi'
  file                   = "$toolsDir\mattermost-desktop-4.6.1-x86.msi"
  file64                 = "$toolsDir\mattermost-desktop-4.6.1-x64.msi"
  checksum               = 'EB892161A8DBE3F82D0A2181E6D201F0572EF53722C2752E105CFF634DBBFB23'
  checksum64             = '526C57151D74A50693605E261508E9FDB40049CC1778B666CC9C8C1064DE69F4'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes         = @(0, 3010, 1641)
  softwareName           = 'Mattermost*'
}

Install-ChocolateyInstallPackage @packageArgs

# Lets remove the installer and ignore files as there is no more need for them
Get-ChildItem $toolsDir\*.msi | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
