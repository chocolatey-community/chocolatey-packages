$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'keepassxc'
  softwareName   = 'KeePassXC'
  fileType       = 'msi'
  file           = "$toolsDir\KeePassXC-2.5.1-Win32.msi"
  file64         = "$toolsDir\KeePassXC-2.5.1-Win64.msi"
  checksum       = '57BB2FBCFFF3488163F10356E2D8EA8C89A32EFF8DCE04BEE5C870225838D8CC'
  checksumType   = 'sha256'
  checksum64     = 'EBADA0B8A45E2202DF844DB0F569DF9E8E0B894423DBC49B04445000F17D4D50'
  checksumType64 = 'sha256'

  # MSI
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

# Lets remove the installer and ignore files as there is no more need for them
Get-ChildItem $toolsDir\*.$packageArgs['fileType'] | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
