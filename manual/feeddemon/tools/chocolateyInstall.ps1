$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    ='feeddemon'
  fileType       = 'exe'

  checksum       = 'A60A4E8DFD0F194E235F232FB525F84A6F6984E910E3C44B2DE772F3035601DD'
  checksumType   = 'sha256'
  url            = 'http://bradsoft.com/download/FeedDemonInstall45.exe'

  silentArgs     = '/verysilent'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
