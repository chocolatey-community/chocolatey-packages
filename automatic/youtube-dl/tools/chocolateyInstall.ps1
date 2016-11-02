$packageName = 'youtube-dl'
$url = 'https://github.com/rg3/youtube-dl/releases/download/2016.11.02/youtube-dl.exe'
$checksum = '5d7ce38ebfb5e0cab36f0a63b1c9a92102beb6650e6e66099f3364b467cffa11529c627284eddc8c0bb197c9a750d0297e907a998883f70d243a43b548f1056e'
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
