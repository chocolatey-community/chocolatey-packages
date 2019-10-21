$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName            = 'mattermost-desktop'
  fileType               = 'msi'
  file                   = "$toolsDir\mattermost-desktop-v4.3.0-x86.msi"
  file64                 = "$toolsDir\mattermost-desktop-v4.3.0-x64.msi"
  checksum               = '3A26EBE0BE519FF7A9CDD45E96AFAD2CE49FA6E1C5B1B639E12161A3A60AC242'
  checksum64             = '8E20940BDFE1D476D7A8D9E4F159A9BDF9F275638F053CC3167664194C0AAF3D'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes         = @(0, 3010, 1641)
  softwareName           = 'Mattermost*'
}

Install-ChocolateyInstallPackage @packageArgs

# Lets remove the installer and ignore files as there is no more need for them
Get-ChildItem $toolsDir\*.msi | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
