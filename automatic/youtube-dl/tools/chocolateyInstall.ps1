$packageName = 'youtube-dl'
$url = 'https://github.com/rg3/youtube-dl/releases/download/2016.12.15/youtube-dl.exe'
$checksum = '534948676578c7fedf16c1df7aa729712b43b7b10ed792b3bbc6d73d733d3f3c2e43eb93f4b1711bf4b7227a2396c1d860591f23f8203a4f27c374d1e26a1300'
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
