$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$pp = Get-PackageParameters
$installDir = $toolsPath
if ($pp.InstallDir -or $pp.InstallationPath ) { $InstallDir = $pp.InstallDir + $pp.InstallationPath }
Write-Host "Sysinternals Suite is going to be installed in '$installDir'"

$packageArgs = @{
  packageName    = 'sysinternals'
  url            = 'https://download.sysinternals.com/files/SysinternalsSuite.zip'
  checksum       = '7d7a4959648026edcb4375603e5ddd279de2c1f91e7a003e65b1ca635c3db4d0'
  checksumType   = 'sha256'
  unzipLocation  = $installDir
}
Install-ChocolateyZipPackage @packageArgs
Accept-Eula
if ($installDir -ne $toolsPath) { Install-ChocolateyPath $installDir }
if (Is-NanoServer) {
  $packageArgs.url = 'https://download.sysinternals.com/files/SysinternalsSuite-Nano.zip'
  $packageArgs.checksum = '369c8906e82d51bfa0a636392aa9d8ecc0ed025609aabead8ea18d5925a2761e'
 }

$old_path = 'c:\sysinternals'
if ((Test-Path $old_path) -and ($installDir -ne $old_path)) {
    Write-Warning "Clean up older versions of this install at c:\sysinternals"
}
