$packageName  = 'alldup'
$url          = 'http://www.alldup.info/download/AllDupSetup.exe'
$checksum     = 'aa2af18bd14409459e869a7d211f67e00a0c4ef0b1d8a744686c24fd538299df'
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
