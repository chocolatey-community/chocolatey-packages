$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'keepassxc'
  softwareName   = 'KeePassXC'
  fileType       = 'msi'
  file           = "$toolsDir\KeePassXC-2.4.3-Win32.msi"
  file64         = "$toolsDir\KeePassXC-2.4.3-Win64.msi"
  checksum       = '259E01AB1F8480A2B02F3805FF91D09C34210861E789372488B877EDFEC3C497'
  checksumType   = 'sha256'
  checksum64     = 'B70C1F82A2243940D9C9F4EC770DDAE785200AEA53E92E149E79282989FD01B8'
  checksumType64 = 'sha256'

  # MSI
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

# Lets remove the installer and ignore files as there is no more need for them
Get-ChildItem $toolsDir\*.$packageArgs['fileType'] | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
