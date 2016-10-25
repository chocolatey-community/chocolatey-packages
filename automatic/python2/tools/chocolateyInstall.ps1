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
  url            = 'https://www.python.org/ftp/python/2.7.12/python-2.7.12.msi'
  url64Bit       = 'https://www.python.org/ftp/python/2.7.12/python-2.7.12.msi'
  checksum       = '3ac291535bcf15fd5a15bcd29b066570e8d2a0cab4f3b92a2372f41aa09a4f48'
  checksum64     = '3ac291535bcf15fd5a15bcd29b066570e8d2a0cab4f3b92a2372f41aa09a4f48'
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
