$packageName = 'youtube-dl'
$url = 'https://github.com/rg3/youtube-dl/releases/download/2016.12.01/youtube-dl.exe'
$checksum = '55ae7a6cbcc2e05c53d78b59364f2a8f91c3e99033d0c222bfc7daf3f5384be83cd3a00b868a9f3fc568279125a06aa68b58fd6a6fdb72575e3b7aeb3c56f7ab'
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
