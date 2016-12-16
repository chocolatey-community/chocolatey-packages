$ErrorActionPreference = 'Stop'

$packageName = 'ffmpeg'

$packageArgs = @{
  packageName    = $packageName
  url            = 'https://ffmpeg.zeranoe.com/builds/win32/static/ffmpeg-3.2.2-win32-static.zip'
  url64Bit       = 'https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-3.2.2-win64-static.zip'
  checksum       = 'c04331e9aed7968e58dc2320046b8d230184adcdb9d3ac035085239ba1f7ab0d'
  checksum64     = '5446374cf7c09c129f4b1d10566f98d9bbba5ea88492e8087c68043db430e523'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  unzipLocation  = Split-Path $MyInvocation.MyCommand.Definition
}
$is32bit = (Get-ProcessorBits 32) -or ($Env:chocolateyForceX86 -eq 'true')

$url          = if ($is32bit) { $packageArgs.url } else { $packageArgs.url64Bit }
$fileName     = $url -split '/' | select -last 1
$download_dir = "$Env:TEMP\chocolatey\$packageName\$Env:ChocolateyPackageVersion"

$file_path = "$download_dir\$fileName"
$options =  @{ Headers=@{ Referer = $url -replace '/[^/]+$'} }
Get-WebFile -Url $url -FileName $file_path -Options $options

if ($is32bit) { $packageArgs.url = $file_path } else { $packageArgs.url64Bit = $file_path }
Install-ChocolateyZipPackage @packageArgs
