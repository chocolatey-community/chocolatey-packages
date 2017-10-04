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
  url            = 'https://www.python.org/ftp/python/3.6.3/python-3.6.3.exe'
  url64Bit       = 'https://www.python.org/ftp/python/3.6.3/python-3.6.3-amd64.exe'
  checksum       = 'cb3bfe1e6b0d1254cebf9bb1fc095fe74396af8baf65f244d5f9b349d232b280'
  checksum64     = '8c83a06dce3576b65f586c2a5992febc816bed3ec5f9205e47ae0ca8581f08a7'
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
