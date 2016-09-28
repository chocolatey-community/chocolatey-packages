# This file should be identical for all python3* packages
# https://docs.python.org/3/using/windows.html#installing-without-ui

$packageName = 'python3'
$url32       = 'https://www.python.org/ftp/python/3.5.2/python-3.5.2.exe'
$url64       = 'https://www.python.org/ftp/python/3.5.2/python-3.5.2-amd64.exe'
$checksum32  = '529c46b9fd3dcf83029b8bfc95034e640ea2c69835b1aa4b75edeec8de764193'
$checksum64  = '2cfcdc77a0ba403acf72ba217898fb7c06ce778a5cb85f5220fd32127e40f263'

$installDir   = '{0}\Python{1}' -f $Env:SystemDrive, ($Env:ChocolateyPackageVersion -replace '\.').Substring(0,2)
$installArgs  = '/quiet InstallAllUsers=1 PrependPath=1 TargetDir="{0}"' -f $installDir
if ($Env:ChocolateyPackageParameters -match '/InstallDir:\s*(.+)') {
    $installDir = $Matches[1]
    if ($installDir.StartsWith("'") -or $installDir.StartsWith('"')){  $installDir = $installDir -replace '^.|.$' }
    $parent = Split-Path $installDir
    mkdir -force $parent -ea 0 | out-null
}

$params = @{
  packageName    = $packageName
  fileType       = 'EXE'
  silentArgs     = $installArgs
  url            = $url32
  url64Bit       = $url64
  checksum       = $checksum32
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}

# If the package is only intended for the 32-bit version, only pass
# the 32-bit version to the install package function.
if ($packageName -match 32) {
    $params.Remove('url64Bit')
    $params.Remove('checksum64')
}

Write-Host "Installing to '$installDir'"
Install-ChocolateyPackage @params

if (($Env:PYTHONHOME -ne $null) -and ($Env:PYTHONHOME -ne $InstallDir)) {
   Write-Warning "Environment variable PYTHONHOME points to different version: $Env:PYTHONHOME"
}

# Generate .ignore files for unwanted .exe files
$exesLeftToPathInclude = @('python.exe', 'pythonw.exe', 'pip.exe', 'easy_install.exe');
Write-Host "Iterating $installDir"
Get-ChildItem -Path $installDir -Recurse | Where {
  $_.Extension -eq '.exe'} | % {
  # Exclude .exe files that should en up in PATH
    if (!($exesLeftToPathInclude -contains $_.Name)) {
      New-Item $($_.FullName + '.ignore') -Force -ItemType file
    }
# Suppress output of New-Item
} | Out-Null
