$packageName = 'youtube-dl'
$url = 'https://github.com/rg3/youtube-dl/releases/download/2016.11.22/youtube-dl.exe'
$checksum = 'f1f17045d7f1bd14c5c3bbc5d863f9433ce74d9cf243016571377ed939471167e7480eca7c80e273a0d24fb76733b5a8c22971fd28ca3b5a4e2292c176837949'
$checksumType = 'sha512'

$installDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$exeDir = "$installDir\youtube-dl.exe"

$packageArgs = @{
  packageName = $packageName
  fileFullPath = $exeDir

  checksum = $checksum
  checksumType = $checksumType
  url = $url
}

Get-ChocolateyWebFile @packageArgs
