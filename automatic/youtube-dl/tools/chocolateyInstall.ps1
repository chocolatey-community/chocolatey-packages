$packageName = 'youtube-dl'
$url = 'https://github.com/rg3/youtube-dl/releases/download/2016.12.20/youtube-dl.exe'
$checksum = '26f5fc48ed58891ccf8f1c8f31cb0d1bc2a6505e61b35336e650abdfa5752ec2cd62b55403bc547dbb35cdb17bf8cffd8d4fb23ac31dc6e5f68245a9db9e3e65'
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
