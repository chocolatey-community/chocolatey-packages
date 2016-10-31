$packageName = 'youtube-dl'
$url = 'https://github.com/rg3/youtube-dl/releases/download/2016.10.31/youtube-dl.exe'
$checksum = 'ca148cbf08c8daaaa8830ddb4ba0ba8824bd82491a621320f0117c5d4c0ec8a258618ee14b7f311387324bb7e3232213386e049bd196af33950ef2d8cc841c73'
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
