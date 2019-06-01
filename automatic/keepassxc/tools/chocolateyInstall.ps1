$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'keepassxc'
  softwareName   = 'KeePassXC'
  fileType       = 'msi'
  file           = "$toolsDir\KeePassXC-2.4.2-Win32.msi"
  file64         = "$toolsDir\KeePassXC-2.4.2-Win64.msi"
  checksum       = 'D5959180A5D14269AA70A827DAF38CFF217065D9EB911471E9924DA0DE9519F9'
  checksumType   = 'sha256'
  checksum64     = '5818D30BB81037D0084148BB571B634CB5359FB036A876A780CA2B0C86B56D90'
  checksumType64 = 'sha256'

  # MSI
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

# Lets remove the installer and ignore files as there is no more need for them
Get-ChildItem $toolsDir\*.$packageArgs['fileType'] | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
