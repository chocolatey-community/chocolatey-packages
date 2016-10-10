$packageName  = 'alldup'
$silentArgs   = '/VERYSILENT'
$url          = 'http://www.alldup.info/download/alldup.exe'
$checksum     = '18f7b97880f6b56c9dfa621d6b6c0ec04edbb1b7923c93bffd72952effdc91e2'
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
