$packageName = 'youtube-dl'
$url = 'https://github.com/rg3/youtube-dl/releases/download/2016.10.19/youtube-dl.exe'
$checksum = 'e81ce832db40b7eeb2efda70b7f5466d507f1ef20609c807ad8b06a1c9cbc5a821a180c85a2a2a0334b5cf8521615675463aff630af9f5181918d74821981136'
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
