$ErrorActionPreference = 'Stop'

$pp = Get-PackageParameters
$silentArgs = '/S /FULL=1'
$silentArgs += if ($pp.NoShellExtension)     { " /SHELLEXTENSION=0"; Write-Host 'Shell extension disabled' }
$silentArgs += if ($pp.DisableUsageTracking) { " /DISABLE_USAGE_TRACKING=1"; Write-Host 'Usage tracking disabled'}
$silentArgs += if ($pp.NoBootInterface)      { " /BOOT=0"; Write-Host 'Boot interface disabled'}

$packageArgs = @{
  packageName    = 'ultradefrag'
  fileType       = 'exe'
  url            = 'https://downloads.sourceforge.net/ultradefrag/ultradefrag-7.0.2.bin.i386.exe'
  url64bit       = 'https://downloads.sourceforge.net/ultradefrag/ultradefrag-7.0.2.bin.amd64.exe'
  checksum       = '69ea62c2987b869bcd21e7a7a7ae65d01ee9a853ace33b5bc973bbcbaa8a4123'
  checksum64     = '34cfc8b7a2b43891e0a7527fc27549b2b3372330f82cf95d32c1744429d2820f'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = $silentArgs
  validExitCodes = @(0)
  softwareName   = 'Ultra Defragmenter'
}
Install-ChocolateyPackage @packageArgs
