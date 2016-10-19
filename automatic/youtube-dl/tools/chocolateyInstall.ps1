$packageName = 'youtube-dl'
$url = 'https://github.com/rg3/youtube-dl/releases/download/2016.10.16/youtube-dl.exe'
$checksum = '6b2e8b2f8c72b0066b1ed4175905c8fcdebf41ba92f42d812259d7a5a4f438b0ba57d3ae1d471b944b708eb99cc9d42ad43820a8a4756416cf6996c7ed899f0a'
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
