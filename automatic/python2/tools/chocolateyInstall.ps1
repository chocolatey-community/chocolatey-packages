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
  url            = 'https://www.python.org/ftp/python/2.7.14/python-2.7.14.msi'
  url64Bit       = 'https://www.python.org/ftp/python/2.7.14/python-2.7.14.amd64.msi'
  checksum       = '450bde0540341d4f7a6ad2bb66639fd3fac1c53087e9844dc34ddf88057a17ca'
  checksum64     = 'af293df7728b861648162ba0cd4a067299385cb6a3f172569205ac0b33190693'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}

# If the package is only intended for the 32-bit version, only pass
# the 32-bit version to the install package function.
if ($packageName -match 32) {  'url64Bit', 'checksum64' | % $params.Remove($_) }

Install-ChocolateyPackage @params
Write-Host "Installed to '$installDir'"

if (($Env:PYTHONHOME -ne $null) -and ($Env:PYTHONHOME -ne $InstallDir)) {
   Write-Warning "Environment variable PYTHONHOME points to different version: $Env:PYTHONHOME"
}

Write-Host "Adding $installDir to PATH if needed"
Install-ChocolateyPath $installDir 'Machine'
