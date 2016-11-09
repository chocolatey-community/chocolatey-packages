$ErrorActionPreference = 'Stop'

$pp = Get-PackageParameters
$silentArgs = '/S /FULL=1'
$silentArgs += if ($pp.NoShellExtension)     { " /SHELLEXTENSION=0"; Write-Host 'Shell extension disabled' }
$silentArgs += if ($pp.DisableUsageTracking) { " /DISABLE_USAGE_TRACKING=1"; Write-Host 'Usage tracking disabled'}
$silentArgs += if ($pp.NoBootInterface)      { " /BOOT=0"; Write-Host 'Boot interface disabled'}

$packageArgs = @{
  packageName    = 'ultradefrag'
  fileType       = 'exe'
  url            = 'http://downloads.sourceforge.net/ultradefrag/ultradefrag-7.0.1.bin.i386.exe'
  url64bit       = 'http://downloads.sourceforge.net/ultradefrag/ultradefrag-7.0.1.bin.amd64.exe'
  checksum       = '0b86c593c60551e85ccba411ec1e8a70ecf9f244a51ce115015c6c4af773196f'
  checksum64     = '554beef1b969b4dec2fd5041d442bc1142c550e02d38c1fd9b3d552bad1f9e99'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = $silentArgs
  validExitCodes = @(0)
  softwareName   = 'ultradefrag*'
}
Install-ChocolateyPackage @packageArgs
