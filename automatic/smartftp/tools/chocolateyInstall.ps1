$ErrorActionPreference = 'Stop'

if ([System.Environment]::OSVersion.Version -lt (new-object 'Version' 6, 3)) {
  $packageName = 'smartftp'
  $errorMessage = 'Your Windows version is not suitable for this package. This package is only for Windows 8.1 or higher'
  Write-Output $packageName $errorMessage
  throw $errorMessage
}

$packageArgs = @{
  packageName            = 'smartftp'
  fileType               = 'msi'
  url                    = 'https://www.smartftp.com/get/SmartFTP86.msi'
  url64bit               = 'https://www.smartftp.com/get/SmartFTP64.msi'
  checksum               = '6a5cd221c84246d5204611a0a4e30f138c8138321ee0abc5dfc98fff0114b6b4'
  checksum64             = 'e3346acd5e8d3f1524f6be5f0ae90da2afd88e0a43856fe5ba0c1fbed1613429'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet'
  validExitCodes         = @(0)
  softwareName           = 'SmartFTP Client'
}
Install-ChocolateyPackage @packageArgs
