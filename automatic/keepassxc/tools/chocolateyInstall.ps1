$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'keepassxc'
  softwareName   = 'KeePassXC'
  fileType       = 'msi'
  file           = "$toolsDir\KeePassXC-2.4.0-beta2-Win32.msi"
  file64         = "$toolsDir\KeePassXC-2.4.0-beta2-Win64.msi"
  checksum       = '7F33F2ACFD06C69F34DCD1E8611BEA3669E956943AFA4E6F506899BC924096FC'
  checksumType   = 'sha256'
  checksum64     = '4F7A6D790B1780C3ED8459D4814FE81D4EE4BBA8972B992208B364436D1EB241'
  checksumType64 = 'sha256'

  # MSI
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

# Lets remove the installer and ignore files as there is no more need for them
Get-ChildItem $toolsDir\*.$packageArgs['fileType'] | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
