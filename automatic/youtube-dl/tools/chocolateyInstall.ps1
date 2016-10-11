$packageName = 'youtube-dl'
$url = 'https://github.com/rg3/youtube-dl/releases/download/2016.10.07/youtube-dl.exe'
$checksum = 'eb38bfadca7b68dbf18e5f2fe9d30cbff383b13563e366e9382c16b8d6a1660b58fa62be1979ae6b77f0eee05d70185f77d581fa71a5c14b5b2aeb8d1b0bf03d'
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
