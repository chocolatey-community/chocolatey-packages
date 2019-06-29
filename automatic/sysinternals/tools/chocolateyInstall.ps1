$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$pp = Get-PackageParameters
$installDir = $toolsPath
if ($pp.InstallDir -or $pp.InstallationPath ) { $InstallDir = $pp.InstallDir + $pp.InstallationPath }
Write-Host "Sysinternals Suite is going to be installed in '$installDir'"

$packageArgs = @{
  packageName    = 'sysinternals'
  url            = 'https://download.sysinternals.com/files/SysinternalsSuite.zip'
  checksum       = 'db59efe1739a2262104874347277f9faa0805a1a7a0acd9cc29e9544fb8040c5'
  checksumType   = 'sha256'
  unzipLocation  = $installDir
}
Install-ChocolateyZipPackage @packageArgs
Accept-Eula
if ($installDir -ne $toolsPath) { Install-ChocolateyPath $installDir }
if (Is-NanoServer) {
  $packageArgs.url = 'https://download.sysinternals.com/files/SysinternalsSuite-Nano.zip'
  $packageArgs.checksum = '58941cfc229570db8290369758e2ae4d551eff85c7c5419767d645bb69495457'
 }

$old_path = 'c:\sysinternals'
if ((Test-Path $old_path) -and ($installDir -ne $old_path)) {
    Write-Warning "Clean up older versions of this install at c:\sysinternals"
}
