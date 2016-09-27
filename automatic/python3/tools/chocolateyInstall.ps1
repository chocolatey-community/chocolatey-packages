# This file should be identical for all python3* packages

$packageName = '{{PackageName}}'
$url32       = '{{DownloadUrl}}'
$url64       = '{{DownloadUrlx64}}'
$checksum32  = ''
$checksum64  = ''
$fileType    = 'exe'
$partialInstallArgs = '/quiet InstallAllUsers=1 PrependPath=1'

$installPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$installArgs = $($partialInstallArgs + ' TargetDir="' + $installPath + '"')

# If the package is only intended for the 32-bit version, only pass
# the 32-bit version to the install package function.
if ($packageName -match 32) {
  Install-ChocolateyPackage $packageName $fileType $installArgs $url32 -Checksum $checksum32 -ChecksumType sha256
} else {
  Install-ChocolateyPackage $packageName $fileType $installArgs $url32 $url64 -Checksum $checksum32 -ChecksumType sha256 -Checksum64 $checksum64 -ChecksumType64 sha256
}

# Generate .ignore files for unwanted .exe files
$exesLeftToPathInclude = @('python.exe', 'pythonw.exe', 'pip.exe', 'easy_install.exe');
Get-ChildItem -Path $installPath -Recurse | Where {

  $_.Extension -eq '.exe'} | % {
  # Exclude .exe files that should en up in PATH
    if (!($exesLeftToPathInclude -contains $_.Name)) {
      New-Item $($_.FullName + '.ignore') -Force -ItemType file
    }
# Suppress output of New-Item
} | Out-Null
