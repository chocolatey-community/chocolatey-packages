$ErrorActionPreference = 'Stop'

$packageName = 'ffmpeg'

$packageArgs = @{
  packageName    = $packageName
  url            = 'https://ffmpeg.zeranoe.com/builds/win32/static/ffmpeg-3.2-win32-static.zip'
  url64Bit       = 'https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-3.2-win64-static.zip'
  checksum       = 'd706d64dc9f81afd17c8d8f0a25e10741249223020f6894f7d2a90a237fa109b'
  checksum64     = '9e1cbb9b73ac3291b3349e4531b39068b6df54fcb486d97e84383e551a40712b'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  unzipLocation  = Split-Path $MyInvocation.MyCommand.Definition
}
$is32bit = (Get-ProcessorBits 32) -or ($Env:chocolateyForceX86 -eq 'true')

$url          = if ($is32bit) { $packageArgs.url } else { $packageArgs.url64Bit }
$fileName     = Split-Path -Leaf $url
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$file_path = "$download_dir\$fileName"
$options =  @{ Headers=@{ Referer = $url -replace '/[^/]+$'} }
Get-WebFile -Url $url -FileName $file_path -Options $options

if ($is32bit) { $packageArgs.url = $file_path } else { $packageArgs.url64Bit = $file_path }
Install-ChocolateyZipPackage @packageArgs
