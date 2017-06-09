$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$pp = Get-PackageParameters
$installDir = $toolsPath
if ($pp.InstallDir -or $pp.InstallationPath ) { $InstallDir = $pp.InstallDir + $pp.InstallationPath }
Write-Host "Sysinternals Suite is going to be installed in '$installDir'"

$packageArgs = @{
  packageName    = 'sysinternals'
  url            = 'https://download.sysinternals.com/files/SysinternalsSuite.zip'
  checksum       = '9c55cef14e4cfd65cdd2caa27f3a718d68bdb7b9bda14a54139b08b40b96015d'
  checksumType   = 'sha256'
  unzipLocation  = $installDir
}
Install-ChocolateyZipPackage @packageArgs
Accept-Eula
if ($installDir -ne $toolsPath) { Install-ChocolateyPath $installDir }
if (Is-NanoServer) {
  $packageArgs.url = 'https://download.sysinternals.com/files/SysinternalsSuite-Nano.zip'
  $packageArgs.checksum = '79b6ec8db89b42ef3863b640c029d59925081f576c254a084437558d0a62ea1a'
 }

$old_path = 'c:\sysinternals'
if ((Test-Path $old_path) -and ($installDir -ne $old_path)) {
    Write-Warning "Clean up older versions of this install at c:\sysinternals"
}
