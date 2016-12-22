$packageName = 'youtube-dl'
$url = 'https://github.com/rg3/youtube-dl/releases/download/2016.12.22/youtube-dl.exe'
$checksum = '2a7c188abeb21a608d9243c324ea7e2a0b6c3e56f5a393b8a125567f307aaddb3bf51291b6df05db6e08951691b925481e00b65bf9b5d9c47ece7fe5ab08436b'
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
