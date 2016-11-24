$ErrorActionPreference = 'Stop'

$packageName = 'Quicktime'
$fileType    = 'msi'
$silentArgs  = '/quiet'
$filePath    = Get-PackageCacheLocation

Install-ChocolateyZipPackage `
  -PackageName $packageName `
  -Url '' `
  -UnzipLocation $filePath `
  -Checksum '' `
  -ChecksumType ''

$packageName = 'appleapplicationsupport'
$file = "$filePath\AppleApplicationSupport.msi"
Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file

$packageName = 'Quicktime'
$file = "$filePath\QuickTime.msi"
Install-ChocolateyInstallPackage $packageName $fileType $silentArgs $file
