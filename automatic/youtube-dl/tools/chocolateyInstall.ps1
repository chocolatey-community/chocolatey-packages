$packageName = 'youtube-dl'
$url = 'https://github.com/rg3/youtube-dl/releases/download/2016.11.08.1/youtube-dl.exe'
$checksum = 'f84b621f37aecc87e2e83a6bf41c8b85c4e66962befc7637d1a5d3b045fdcf113afadc64c25d0af0573dc30a18ee014a68338dd58df69bb3539c6a89a2121b5d'
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
