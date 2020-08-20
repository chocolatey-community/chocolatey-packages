$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'keepassxc'
  softwareName   = 'KeePassXC'
  fileType       = 'msi'
  file           = "$toolsDir\KeePassXC-2.6.1-Win32.msi"
  file64         = "$toolsDir\KeePassXC-2.6.1-Win64.msi"
  checksum       = 'B33F233D3613B7198F2C42F5ECCD8E75668E98A19CA9D58B26A780D5C02F65DE'
  checksumType   = 'sha256'
  checksum64     = '2761465EBD9A9A02A714F1D27EE7B0B5965DB1A3D4057EA4138344C7F66EA9CB'
  checksumType64 = 'sha256'

  # MSI
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

# Lets remove the installer and ignore files as there is no more need for them
Get-ChildItem $toolsDir\*.$packageArgs['fileType'] | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
