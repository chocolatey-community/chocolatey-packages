# This file should be identical for all python3* packages
# https://docs.python.org/3/using/windows.html#installing-without-ui

$packageName = '{{PackageName}}'
$url32       = '{{DownloadUrl}}'
$url64       = '{{DownloadUrlx64}}'
$checksum32  = ''
$checksum64  = ''

if ($Env:ChocolateyPackageParameters -match '/InstallDir:\s*(.+)') {
    $installDir = $Matches[1]
    if ($installDir.StartsWith("'") -or $installDir.StartsWith('"')){  $installDir = $installDir -replace '^.|.$' }
    $parent = Split-Path $installDir
    mkdir -force $parent -ea 0 | out-null
}

$installDir   = '{0}\Python{1}' -f $Env:SystemDrive, ($Env:ChocolateyPackageVersion -replace '\.').Substring(0,2)
$installArgs  = '/quiet InstallAllUsers=1 PrependPath=1 TargetDir="{0}"' -f $installDir
Write-host $installArgs

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

# Generate .ignore files for unwanted .exe files
$exesLeftToPathInclude = @('python.exe', 'pythonw.exe', 'pip.exe', 'easy_install.exe');
Get-ChildItem -Path $installDir -Recurse | Where {

  $_.Extension -eq '.exe'} | % {
  # Exclude .exe files that should en up in PATH
    if (!($exesLeftToPathInclude -contains $_.Name)) {
      New-Item $($_.FullName + '.ignore') -Force -ItemType file
    }
# Suppress output of New-Item
} | Out-Null
