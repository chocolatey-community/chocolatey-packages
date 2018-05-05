$packageName  = 'alldup'
$url          = 'http://www.alldup.info/download/AllDupSetup.exe'
$checksum     = 'e0cea1d2469c5f1d13efca9823db19d10e748a792aa5452ce65fc7663bb57eae'
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
