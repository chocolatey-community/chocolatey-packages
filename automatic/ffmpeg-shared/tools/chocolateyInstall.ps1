$ErrorActionPreference = 'Stop';
$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-full-shared.7z'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsPath
  url           = $url
  checksum      = '19f7ddacc3795d1168f14843d3233161dc474df4b981cc6158da614d0e00e339'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs

Write-Host "$packageName installed to $toolsPath"
