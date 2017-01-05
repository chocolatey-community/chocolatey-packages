$packageName = 'youtube-dl'
$url = 'https://github.com/rg3/youtube-dl/releases/download/2017.01.05/youtube-dl.exe'
$checksum = '5231e91bd6a1b09ee43270d6ed83b914ba6412ccbc09ae5edda5cff45e5195d479d43bcc419928e2e05c7984e091a1c4f5eaa1e545cb791a455546279ff4d551'
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
