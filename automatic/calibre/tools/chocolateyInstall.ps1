$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'MSI'
  url            = 'https://download.calibre-ebook.com/4.19.0/calibre-4.19.0.msi'
  checksum       = 'A09B3075E3BB6FA1B1AED2FAB68A0C44DCEA0F23B3B1C1C6722EBF2186711DF2'
  checksumType   = 'sha256'
  file64         = "$toolsPath\calibre-64bit-4.19.0.msi"
  softwareName   = 'calibre*'
  silentArgs     = '/quiet'
  validExitCodes = @(0, 3010, 1641)
}

if ((Get-OSArchitectureWidth -compare 32) -or ($env:chocolateyForceX86 -eq $true)) {
  Install-ChocolateyPackage @packageArgs
}
else {
  Install-ChocolateyInstallPackage @packageArgs
}

Remove-Item -Force -ea 0 "$toolsPath\*.msi","$toolsPath\*.ignore"
