$packageName  = 'alldup'
$url          = 'http://update.antp.be/renamer/antrenamer2_install.exe'
$checksum     = '866327c8c5e36e1e525da37ccdb40924e16ce5a5772ff67414b62b9d508cf2e5'
$checksumType = 'sha256'

$packageArgs  = @{
  packageName    = $packageName
  fileType       = 'exe'
  softwareName   = 'Ant Renamer'

  checksum       = $checksum
  checksumType   = $checksumType
  url            = $url

  silentArgs     = '/VERYSILENT'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
