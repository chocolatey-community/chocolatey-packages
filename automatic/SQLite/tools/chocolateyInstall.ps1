$ErrorActionPreference = 'Stop'

$packageName    = 'sqlite'
$url32          = 'https://sqlite.org/2017/sqlite-dll-win32-x86-3170000.zip'
$url64          = $url32
$checksum32     = 'dc7f8b3493543dc086cb43b66401893597f993408f18b437e5c8e8b5544db0bf'
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
