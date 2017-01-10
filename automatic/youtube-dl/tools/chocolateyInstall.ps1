$packageName = 'youtube-dl'
$url = 'https://github.com/rg3/youtube-dl/releases/download/2017.01.10/youtube-dl.exe'
$checksum = '8f1e40c34ec73af23d825d5ba206bd0fc562ea060e7b29c18234572078f55a3345fc11f6c3882568aa2222a0e21b5200f6f88265213217a58ea1dbc337014688'
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
