$packageName = 'youtube-dl'
$url = 'https://github.com/rg3/youtube-dl/releases/download/2016.11.18/youtube-dl.exe'
$checksum = '556e7e087cb577527583d336e332871618e5aab6c8fd6656d415d25b6c5da1129daed2e522c0fbd78d53c5f03aec965fda2ee7d9e2247ec031ed15c008cc1bc7'
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
