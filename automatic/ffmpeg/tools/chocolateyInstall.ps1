$ErrorActionPreference = 'Stop'

$packageName = 'ffmpeg'

$packageArgs = @{
  packageName    = $packageName
  url            = 'https://ffmpeg.zeranoe.com/builds/win32/static/ffmpeg-3.1.5-win32-static.zip'
  url64Bit       = 'https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-3.1.5-win64-static.zip'
  checksum       = '8f19d37cddcfde6e2a0c5791ac5228252f97be1a52268aaa37d2c5813b08186d'
  checksum64     = '5c6a1263780509db438296e6e6555dc731212564088094ff3a16f0e69f95a633'
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
