$ErrorActionPreference = 'Stop'

$packageName = 'Quicktime'
$fileType    = 'msi'
$silentArgs  = '/quiet'
$filePath    = Get-PackageCacheLocation

Install-ChocolateyZipPackage `
  -PackageName $packageName `
  -Url 'https://secure-appldnld.apple.com/QuickTime/031-43075-20160107-C0844134-B3CD-11E5-B1C0-43CA8D551951/QuickTimeInstaller.exe' `
  -UnzipLocation $filePath `
  -Checksum '56eff77b029b5f56c47d11fe58878627065dbeacbc3108d50d98a83420152c2b' `
  -ChecksumType 'sha256'

$packageName = 'appleapplicationsupport'
$file = "$filePath\AppleApplicationSupport.msi"
Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file

$packageName = 'Quicktime'
$file = "$filePath\QuickTime.msi"
Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file
