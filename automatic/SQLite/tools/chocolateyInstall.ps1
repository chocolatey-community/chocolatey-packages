$ErrorActionPreference = 'Stop'

$packageName    = 'sqlite'
$url32          = 'https://sqlite.org/2016/sqlite-dll-win32-x86-3150000.zip'
$url64          = $url32
$checksum32     = '43a12cc1c155d0bb9686a1fcbc90babc9e99dbec475bddc2acacf31bd2b159e8'
$checksum64     = $checksum32
$instDir        = "$(Get-ToolsLocation)\$packageName"

# Detect if sqlite package uses old/deprecated installation path
$oldInstDir = Join-Path $env:ChocolateyInstall 'bin'
$sqliteFiles = @('sqlite3.dll', 'sqlite3.def')
foreach ($file in $sqliteFiles) {
    $oldFilePath = Join-Path $oldInstDir $file
    if (Test-Path $oldFilePath) { $usesOldPath = $true }
}
if ($usesOldPath) {
  Write-Host @"
Old installation directory for $packageName detected: $oldInstDir
If you want to use the new installation directory (ChocolateyBinRoot\$packageName),
remove the old sqlite*.dll sqlite*.def files and reinstall this package with the -force parameter.
"@
    $instDir = $oldInstDir
}

$packageArgs = @{
  packageName    = $packageName
  url            = $url32
  url64Bit       = $url64
  checksum       = $checksum32
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  unzipLocation  = $instDir
}
Install-ChocolateyZipPackage @packageArgs
if (!$usesOldPath) {
    Install-ChocolateyPath $instDir 'Machine'
    $env:Path = "$($env:Path);$instDir"
}
