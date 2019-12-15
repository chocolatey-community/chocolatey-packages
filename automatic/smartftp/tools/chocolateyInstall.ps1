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
  checksum               = 'ebf6e694c6bb285cdc686be9489153aa719e3abe0e6b8f40534b2b9088fef0ff'
  checksum64             = 'ccde792684a1fd0468144d0aff442409be1df39558fe13e2d39a6726e29de0ac'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet'
  validExitCodes         = @(0)
  softwareName           = 'SmartFTP Client'
}
Install-ChocolateyPackage @packageArgs
