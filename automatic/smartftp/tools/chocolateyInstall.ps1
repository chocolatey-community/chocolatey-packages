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
  checksum               = 'b8d98d9800ea1a3f356605c4b14311b6d82501992443f6c9ab8610d7211bf47a'
  checksum64             = '2941f9ec6aa173d3a96e55a0e0211aa4dbf66de921101f9d13bc0f1b02089164'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet'
  validExitCodes         = @(0)
  softwareName           = 'SmartFTP Client'
}
Install-ChocolateyPackage @packageArgs
