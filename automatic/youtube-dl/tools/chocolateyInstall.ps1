$packageName = 'youtube-dl'
$url = 'https://github.com/rg3/youtube-dl/releases/download/2016.11.27/youtube-dl.exe'
$checksum = '55427ac861c8c5fa8623ea8778c8afe44356a7b283133bdbf24f20b4358000a38b7ad2f74609c0072843936001e5f0596d0d85be6278683cbac100dc3a94ee9c'
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
