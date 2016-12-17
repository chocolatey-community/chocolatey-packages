$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$pp = Get-PackageParameters
$installDir = $toolsPath
if ($pp.InstallDir -or $pp.InstallationPath ) { $InstallDir = $pp.InstallDir + $pp.InstallationPath }
Write-Host "Sysinternals Suite is going to be installed in '$installDir'"

$packageArgs = @{
  packageName    = 'sysinternals'
  url            = 'https://download.sysinternals.com/files/SysinternalsSuite.zip'
  url64Bit       = 'https://download.sysinternals.com/files/SysinternalsSuite.zip'
  checksum       = 'fd6953ef90bf3788874619b63b0b144d02823447f03ddefa6305e34f09eccce0'
  checksum64     = 'fd6953ef90bf3788874619b63b0b144d02823447f03ddefa6305e34f09eccce0'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  unzipLocation  = $installDir
}
Install-ChocolateyZipPackage @packageArgs
Accept-Eula

if ($installDir -ne $toolsPath) {
    Write-Host "Adding to PATH if needed"
    Install-ChocolateyPath $installDir
}

$old_path = 'c:\sysinternals'
if ((Test-Path $old_path) -and ($installDir -ne $old_path)) {
    Write-Warning "Clean up older versions of this install at c:\sysinternals"
}
