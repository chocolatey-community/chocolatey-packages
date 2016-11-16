$packageName  = 'alldup'
$url          = 'http://www.alldup.info/download/AllDupSetup.exe'
$checksum     = '7138dc65c38dd2c6290ebac48b9d209a77797c79cb09023de39a9a96898a3da4'
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
