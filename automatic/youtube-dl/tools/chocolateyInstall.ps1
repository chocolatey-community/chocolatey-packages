$packageName = 'youtube-dl'
$url = 'https://yt-dl.org/downloads/2016.10.02/youtube-dl.exe'
$checksum = ''
$checksumType = ''

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
