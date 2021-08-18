$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$pp = Get-PackageParameters
$installDir = $toolsPath
if ($pp.InstallDir -or $pp.InstallationPath ) { $InstallDir = $pp.InstallDir + $pp.InstallationPath }
Write-Host "Sysinternals Suite is going to be installed in '$installDir'"

$packageArgs = @{
  packageName    = 'sysinternals'
  url            = 'https://download.sysinternals.com/files/SysinternalsSuite.zip'
  checksum       = 'd8eb98f0920cf66b6ef6e87b2946e522a6aee98e28151f4a0c9209ceafd38aff'
  checksumType   = 'sha256'
  unzipLocation  = $installDir
}
Install-ChocolateyZipPackage @packageArgs
Accept-Eula
if ($installDir -ne $toolsPath) { Install-ChocolateyPath $installDir }
if (Is-NanoServer) {
  $packageArgs.url = 'https://download.sysinternals.com/files/SysinternalsSuite-Nano.zip'
  $packageArgs.checksum = 'eeae4fb66d32db20073080c005f2ff624d811a4cf4dfe93bb137d7872644e16e'
 }

$old_path = 'c:\sysinternals'
if ((Test-Path $old_path) -and ($installDir -ne $old_path)) {
    Write-Warning "Clean up older versions of this install at c:\sysinternals"
}
