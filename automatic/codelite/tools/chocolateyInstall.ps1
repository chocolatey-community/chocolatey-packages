$packageName    = 'codelite'
$url32          = 'https://github.com/eranif/codelite/releases/download/9.2/codelite-x86-9.2.0.7z'
$url64          = 'https://github.com/eranif/codelite/releases/download/9.2/codelite-amd64-9.2.0.7z'
$checksum32     = 'ae7cc02c67465ecf21332cbd36687180c14597b669c5c26e45adceee7a558c69'
$checksumType32 = 'sha256'
$checksum64     = 'e368c00cc85be9f12a0c136ba2c80e10159aecc13721b18b41886bf1f960f725'
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
