$packageName = 'youtube-dl'
$url = 'https://github.com/rg3/youtube-dl/releases/download/2016.10.12/youtube-dl.exe'
$checksum = 'e5892e7ac2448e2cf424f679b8a5f42c42278837a5b315cd880584087f276259c5d15ae2a3511a9d939b926d0222186f863b1eb3a39762b747689b1046b1fd9d'
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
