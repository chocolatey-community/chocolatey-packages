# This file should be identical for all python3* packages
# https://docs.python.org/3/using/windows.html#installing-without-ui

$installDir  = '{0}\Python{1}' -f $Env:SystemDrive, ($Env:ChocolateyPackageVersion -replace '\.').Substring(0,2)
if ($Env:ChocolateyPackageParameters -match '/InstallDir:\s*(.+)') {
    $installDir = $Matches[1]
    if ($installDir.StartsWith("'") -or $installDir.StartsWith('"')){  $installDir = $installDir -replace '^.|.$' }
    #$parent = Split-Path $installDir
    mkdir -force $installDir -ea 0 | out-null
}

$params = @{
  packageName    = 'python3'
  fileType       = 'EXE'
  silentArgs     = '/quiet InstallAllUsers=1 PrependPath=1 TargetDir="{0}"' -f $installDir
  url            = 'https://www.python.org/ftp/python/3.6.0/python-3.6.0.exe'
  url64Bit       = 'https://www.python.org/ftp/python/3.6.0/python-3.6.0-amd64.exe'
  checksum       = '8e766027f346741502f49a9839b9fe4a2a3674258da8f9822c892537743532eb'
  checksum64     = 'f35d6fba8c62fc7a03ceae8b1b6edc77249bce8d30d0a16d140afb2ee8f44194'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}

# If the package is only intended for the 32-bit version, only pass
# the 32-bit version to the install package function.
if ($packageName -match 32) { $params.Remove('url64Bit'); $params.Remove('checksum64') }

Install-ChocolateyPackage @params
Write-Host "Installed to '$installDir'"

if (($Env:PYTHONHOME -ne $null) -and ($Env:PYTHONHOME -ne $InstallDir)) {
    Write-Warning "Environment variable PYTHONHOME points to different version: $Env:PYTHONHOME"
}
