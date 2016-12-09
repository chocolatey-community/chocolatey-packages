$packageName = 'youtube-dl'
$url = 'https://github.com/rg3/youtube-dl/releases/download/2016.12.09/youtube-dl.exe'
$checksum = 'c817f695a1cbe5707fe298640386b19f5aa7d310b9bb2453387d68651676a842bfece5b3e83a2cca08478a4dcdaf43d7a86c9d5d9dc26bd367d6cf9cb337b940'
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
