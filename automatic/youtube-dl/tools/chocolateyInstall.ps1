$packageName = 'youtube-dl'
$url = 'https://github.com/rg3/youtube-dl/releases/download/2017.01.08/youtube-dl.exe'
$checksum = 'e04164fc7bcf8b0745fa745e54fff6ce9341890dfad62691d9b8aca386314db5cd114880b838e53ecf0aa0a39f682dc655aca43ed79678a60248a6f433400c0e'
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
