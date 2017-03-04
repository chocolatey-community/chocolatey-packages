$ErrorActionPreference = 'Stop'

if ([System.Environment]::OSVersion.Version -lt (new-object 'Version' 6, 3)) {
  $errorMessage = 'Your Windows version is not suitable for this package. This package is only for Windows 8.1 or higher'
  Write-Output $packageName $errorMessage
  throw $errorMessage
}

$packageArgs = @{
  packageName            = 'smartftp'
  fileType               = 'msi'
  url                    = 'https://www.smartftp.com/get/SmartFTP86.msi'
  url64bit               = 'https://www.smartftp.com/get/SmartFTP64.msi'
  checksum               = 'f8ccfb39815a6cfaf3e397ed6c950bfe62fb81086fea7636c04e357a476cde55'
  checksum64             = '272dcd5a1f034bed10619946a09d75b0f4e765d6b5bc7da543030d41a4795731'
  checksumType           = 'sha256'
  checksumType64         = 'sha256'
  silentArgs             = '/quiet'
  validExitCodes         = @(0)
  softwareName           = 'SmartFTP Client'
}
Install-ChocolateyPackage @packageArgs
