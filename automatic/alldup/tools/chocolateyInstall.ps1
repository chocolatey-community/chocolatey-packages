$packageName  = 'alldup'
$url          = 'http://www.alldup.info/download/AllDupSetup.exe'
$checksum     = '9e849408bede6eafcd4942bdbbb10b82fcb7dd2617c83b95e098d75631b5212c'
$checksumType = 'sha256'

$packageArgs  = @{
  packageName    = $packageName
  fileType       = 'exe'
  softwareName   = 'AllDup*'

  checksum       = $checksum
  checksumType   = $checksumType
  url            = $url

  silentArgs     = '/VERYSILENT'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
