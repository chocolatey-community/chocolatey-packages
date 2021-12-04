$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'MSI'
  url            = 'https://download.calibre-ebook.com/5.33.2/calibre-5.33.2.msi'
  checksum       = '51D2C55C15FBE0BF6A77CD51CEF4951BF5A87966DFB7AA835F9B607AA8F7D531'
  checksumType   = 'sha256'
  file64         = "$toolsPath\calibre-64bit-5.33.2.msi"
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
