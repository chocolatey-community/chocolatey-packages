$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'MSI'
  url            = 'https://download.calibre-ebook.com/5.20.0/calibre-5.20.0.msi'
  checksum       = '8E9B03CD596CC3D2C16E94BBC873919D1CDA68568BB48B65EDE5CA68378D03EB'
  checksumType   = 'sha256'
  file64         = "$toolsPath\calibre-64bit-5.20.0.msi"
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
