$packageName = 'youtube-dl'
$url = 'https://github.com/rg3/youtube-dl/releases/download/2016.12.12/youtube-dl.exe'
$checksum = '1eac846e4ce65dd27efbcd5784436b27a350e2b4b58f4ec4b9e3ee1278007d63b9b64b0a6d3aefa7ef2f2fe2ed4a2e7ddecb4cb581b49ad2129f7531e5b05418'
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
