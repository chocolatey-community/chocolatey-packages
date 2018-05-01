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
  url            = 'https://www.python.org/ftp/python/2.7.15/python-2.7.15.msi'
  url64Bit       = 'https://www.python.org/ftp/python/2.7.15/python-2.7.15.amd64.msi'
  checksum       = '1afa1b10cf491c788baa340066a813d5ec6232561472cfc3af1664dbc6f29f77'
  checksum64     = '5e85f3c4c209de98480acbf2ba2e71a907fd5567a838ad4b6748c76deb286ad7'
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
