$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'keepassxc'
  softwareName   = 'KeePassXC'
  fileType       = 'msi'
  file           = "$toolsDir\KeePassXC-2.4.0-beta1-Win32.msi"
  file64         = "$toolsDir\KeePassXC-2.4.0-beta1-Win64.msi"
  checksum       = 'CB049A6D2C4E418CC6A9D1A775E94FA07A61D2F048649C2C6E139AE21AD12D20'
  checksumType   = 'sha256'
  checksum64     = '0F343A8E7372BC7F8ABF93C87C8EB883E59DE202B3F58B4D779714F2FAC4172C'
  checksumType64 = 'sha256'

  # MSI
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

# Lets remove the installer and ignore files as there is no more need for them
Get-ChildItem $toolsDir\*.$fileType | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
