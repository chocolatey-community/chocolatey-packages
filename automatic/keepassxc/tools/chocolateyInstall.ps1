$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'keepassxc'
  softwareName   = 'KeePassXC'
  fileType       = 'msi'
  file           = "$toolsDir\KeePassXC-2.5.2-Win32.msi"
  file64         = "$toolsDir\KeePassXC-2.5.2-Win64.msi"
  checksum       = '0A97A99EAA83274ACB524978D32BFDDAE5E1500C151A2393318051E4E8BC952F'
  checksumType   = 'sha256'
  checksum64     = '3380D96543795F56ED258EBB82E4A802887EAD6820E314EB7263DC41CDCF2099'
  checksumType64 = 'sha256'

  # MSI
  silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

# Lets remove the installer and ignore files as there is no more need for them
Get-ChildItem $toolsDir\*.$packageArgs['fileType'] | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
