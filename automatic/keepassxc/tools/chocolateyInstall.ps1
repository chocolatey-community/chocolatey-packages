$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'keepassxc'
  softwareName   = 'KeePassXC'
  fileType       = 'msi'
  file           = "$toolsDir\KeePassXC-2.5.4-Win32.msi"
  file64         = "$toolsDir\KeePassXC-2.5.4-Win64.msi"
  checksum       = 'C6A37CD95213273E7F3DA2C3D0DF79389B3D851626D5D47143A5A1EFA953913A'
  checksumType   = 'sha256'
  checksum64     = '01BF1B593EFC4A9B92E0CA7148414F6D4F0E63521AEFA64D1F8CAA0327D35E91'
  checksumType64 = 'sha256'

  # MSI
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

# Lets remove the installer and ignore files as there is no more need for them
Get-ChildItem $toolsDir\*.$packageArgs['fileType'] | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
