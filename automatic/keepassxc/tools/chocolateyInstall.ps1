$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'keepassxc'
  softwareName   = 'KeePassXC'
  fileType       = 'msi'
  file           = "$toolsDir\KeePassXC-2.5.4-Win64.msi"
  file64         = "$toolsDir\KeePassXC-2.5.4-Win64.msi"
  checksum       = '01BF1B593EFC4A9B92E0CA7148414F6D4F0E63521AEFA64D1F8CAA0327D35E91'
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
