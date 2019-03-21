$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'keepassxc'
  softwareName   = 'KeePassXC'
  fileType       = 'msi'
  file           = "$toolsDir\KeePassXC-2.4.0-Win32.msi"
  file64         = "$toolsDir\KeePassXC-2.4.0-Win64.msi"
  checksum       = '38F49720EBB73BAEAB5DA89BA16C4BDCD84BC703939A06EF288F0739DF2E8D54'
  checksumType   = 'sha256'
  checksum64     = '6939A4B64217BDDFB349431EC71B1878CA65D3EBEFAD4BA396CB19045FFB83E7'
  checksumType64 = 'sha256'

  # MSI
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

# Lets remove the installer and ignore files as there is no more need for them
Get-ChildItem $toolsDir\*.$packageArgs['fileType'] | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
