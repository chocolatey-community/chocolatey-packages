$packageName    = 'codelite'
$url32          = 'https://github.com/eranif/codelite/releases/download/9.1/codelite-x86-9.1.0.gz'
$url64          = 'https://github.com/eranif/codelite/releases/download/9.1/codelite-amd64-9.1.0.gz'
$checksum32     = '7991ca32591d6d48b40650f1fb9365cbdb0b773f0d8a0afa25fa30924166da52'
$checksumType32 = 'sha256'
$checksum64     = '0dcf99a68da16abdc1fcb7d5d42a94dbac2e4d145cc176fbb8758f6b9a156e0b'
$checksumType64 = 'sha256'

$extractDir     = "$env:TEMP/$packageName/$env:chocolateyPackageVersion"
$fileType       = 'exe'

$zipArgs        = @{
  packageName    = $packageName
  url            = $url32
  url64          = $url64
  unzipLocation  = $extractDir
  checksum       = $checksum32
  checksumType   = $checksumType32
  checksum64     = $checksum64
  checksumType64 = $checksumType64
}

Install-ChocolateyZipPackage @zipArgs

$executable = Get-ChildItem -Path $extractDir -Filter "*.$fileType" | select -First 1

$packageArgs= @{
  packageName = $packageName
  fileType = $fileType
  silentArgs = '/VERYSILENT /SP- /SUPPRESSMSGBOXES'
  file = "$extractDir/$executable"
  validExitCodes = @(0)
  softwareName = 'CodeLite'
}

Install-ChocolateyInstallPackage @packageArgs
