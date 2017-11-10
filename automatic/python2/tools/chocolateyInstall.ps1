# This file should be identical for all python* packages
# https://docs.python.org/3/using/windows.html#installing-without-ui

$installDir  = '{0}\Python{1}' -f $Env:SystemDrive, ($Env:ChocolateyPackageVersion -replace '\.').Substring(0,2)
if ($Env:ChocolateyPackageParameters -match '/InstallDir:\s*(.+)') {
    $installDir = $Matches[1]
    if ($installDir.StartsWith("'") -or $installDir.StartsWith('"')){  $installDir = $installDir -replace '^.|.$' }
}
$installArgs  = '/qn /norestart ALLUSERS=1 ADDLOCAL=ALL TargetDir="{0}"' -f $installDir

$params = @{
  packageName    = 'python2'
  fileType       = 'msi'
  silentArgs     = $installArgs
  url            = 'https://www.python.org/ftp/python/2.6.6/python-2.6.6.msi'
  url64Bit       = 'https://www.python.org/ftp/python/2.6.6/python-2.6.6.amd64.msi'
  checksum       = '1192931440475d07fb3e9724531a53de34097ad24e519bff2e5f458c375a31b3'
  checksum64     = 'b9ea8892ce58101957a0bb2caa02ccf5496b13a1cc9e24de078d4451b4ef3cf8'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}

Install-ChocolateyPackage @params
Write-Host "Installed to '$installDir'"

if (($Env:PYTHONHOME -ne $null) -and ($Env:PYTHONHOME -ne $InstallDir)) {
   Write-Warning "Environment variable PYTHONHOME points to different version: $Env:PYTHONHOME"
}

Write-Host "Adding $installDir to PATH if needed"
Install-ChocolateyPath $installDir 'Machine'
