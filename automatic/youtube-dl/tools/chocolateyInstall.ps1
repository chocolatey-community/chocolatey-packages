$packageName = 'youtube-dl'
$url = 'https://github.com/rg3/youtube-dl/releases/download/2016.11.14.1/youtube-dl.exe'
$checksum = 'aa155d22114ea56a6ef9b09a5c2d77a0e016f4c35878f24be88d44263e779aea3bbcb3e5903aae21ec6d2d9cc8721177ae1c726fccf65e4643ba1ba46ef5a4c0'
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
