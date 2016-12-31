$packageName = 'youtube-dl'
$url = 'https://github.com/rg3/youtube-dl/releases/download/2016.12.31/youtube-dl.exe'
$checksum = 'cd3c463993b65d04536ffad938938c414491601127898051f6bd52ed8925680944ff95595488ba1e30abbb99c84a4155d5692caa06ffd05118aae148e8abce45'
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
