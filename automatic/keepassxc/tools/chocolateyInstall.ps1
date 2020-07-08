$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'keepassxc'
  softwareName   = 'KeePassXC'
  fileType       = 'msi'
  file           = "$toolsDir\KeePassXC-2.6.0-Win32.msi"
  file64         = "$toolsDir\KeePassXC-2.6.0-Win64.msi"
  checksum       = 'E0E440BAE570DC49431DF456E0F882B9344E8C24CCAD0FEC8B88D21BFFDA40DC'
  checksumType   = 'sha256'
  checksum64     = '9C3924B39773B4DD15D52D97CDF5D66117259742BBE753C84207EB8A82BAB5FB'
  checksumType64 = 'sha256'

  # MSI
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

# Lets remove the installer and ignore files as there is no more need for them
Get-ChildItem $toolsDir\*.$packageArgs['fileType'] | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
