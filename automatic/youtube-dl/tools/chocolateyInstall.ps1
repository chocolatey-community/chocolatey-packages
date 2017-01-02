$packageName = 'youtube-dl'
$url = 'https://github.com/rg3/youtube-dl/releases/download/2017.01.02/youtube-dl.exe'
$checksum = '48fc90d412d922c6257368f96b2481b2081edb5dd8c9b98e0443fb89e4db4e6dd1203beba843d3021cdbb2c5556bd57a98ac34f6871c5438706ba3d0779fa1be'
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
