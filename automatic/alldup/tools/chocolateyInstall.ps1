$packageName  = 'alldup'
$url          = 'http://www.alldup.info/download/AllDupSetup.exe'
$checksum     = '038ca09820c340f5f6f230ea21c218bcc92f22805bbf400218f29411da16ad46'
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
