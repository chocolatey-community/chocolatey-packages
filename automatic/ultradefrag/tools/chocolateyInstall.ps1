$ErrorActionPreference = 'Stop'

$pp = Get-PackageParameters
$silentArgs = '/S /FULL=1'
$silentArgs += if ($pp.NoShellExtension)     { " /SHELLEXTENSION=0"; Write-Host 'Shell extension disabled' }
$silentArgs += if ($pp.DisableUsageTracking) { " /DISABLE_USAGE_TRACKING=1"; Write-Host 'Usage tracking disabled'}
$silentArgs += if ($pp.NoBootInterface)      { " /BOOT=0"; Write-Host 'Boot interface disabled'}

$packageArgs = @{
  packageName    = 'ultradefrag'
  fileType       = ''
  url            = 'https://sourceforge.net/projects/ultradefrag/files/stable-release/7.1.1/ultradefrag-7.1.1.bin.i386.exe/download'
  url64bit       = 'https://sourceforge.net/projects/ultradefrag/files/stable-release/7.1.1/ultradefrag-7.1.1.bin.amd64.exe/download'
  checksum       = 'b73a848214a4d527b2d17054e134ed3732c082cee8cd90bd888973eff54ea953'
  checksum64     = '6f9a0200c75d432af0f8a3585e5ad9aa6e41dbadeb29a365d7033d66770fbc48'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = $silentArgs
  validExitCodes = @(0)
  softwareName   = 'Ultra Defragmenter'
}
Install-ChocolateyPackage @packageArgs
