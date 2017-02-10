$packageName    = 'codelite'
$url32          = 'https://github.com/eranif/codelite/releases/download/10.0/codelite-x86-10.0.0.7z'
$url64          = 'https://github.com/eranif/codelite/releases/download/10.0/codelite-amd64-10.0.0.7z'
$checksum32     = '8f940b234becc3c6cd6f1754d07ed78e1c8136c2701bd9d076dc021dd0a03026'
$checksumType32 = 'sha256'
$checksum64     = '1600ab540848b3422e5151405cb259e98c00a037e4a6ac298dac060b396217f0'
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
