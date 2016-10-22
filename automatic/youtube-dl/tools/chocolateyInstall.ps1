$packageName = 'youtube-dl'
$url = 'https://github.com/rg3/youtube-dl/releases/download/2016.10.21.1/youtube-dl.exe'
$checksum = '65839646a6d018a3e408c5fd0b73937cc2825b7fe200fcd82de5fce0147a4fc8f632d319628bf01dc792e5fc720bce0950c7b00dae78f67a4cd31fb993e6e8f9'
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
