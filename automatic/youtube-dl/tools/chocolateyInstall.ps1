$packageName = 'youtube-dl'
$url = 'https://github.com/rg3/youtube-dl/releases/download/2016.10.26/youtube-dl.exe'
$checksum = 'f0d8bbbdfd723fe414679a250831f7ae6e30c0ae354e2889edfc965fa3a150534bb3af75eae1be719cf7f6dd8722bf9337464e4f48737ccc14b373dac47fb267'
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
