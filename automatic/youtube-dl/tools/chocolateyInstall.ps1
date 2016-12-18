$packageName = 'youtube-dl'
$url = 'https://github.com/rg3/youtube-dl/releases/download/2016.12.18/youtube-dl.exe'
$checksum = 'ebca98e6bd29239fba2897b020ed302196b2ba73649696dd229e3319e11adf31189674b0c23ba6171e31811592582d483a6d3e44eeac0ebe1e7fb07205870f37'
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
