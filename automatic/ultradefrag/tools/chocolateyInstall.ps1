$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -parent $MyInvocation.MyCommand.Definition

$pp = Get-PackageParameters
$silentArgs = '/S /FULL=1'
$silentArgs += if ($pp.NoShellExtension)     { " /SHELLEXTENSION=0"; Write-Host 'Shell extension disabled' }
$silentArgs += if ($pp.DisableUsageTracking) { " /DISABLE_USAGE_TRACKING=1"; Write-Host 'Usage tracking disabled'}
$silentArgs += if ($pp.NoBootInterface)      { " /BOOT=0"; Write-Host 'Boot interface disabled'}

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  file           = "$toolsPath\ultradefrag-7.1.3.bin.i386.exe"
  file64         = "$toolsPath\ultradefrag-7.1.3.bin.amd64.exe"
  silentArgs     = $silentArgs
  validExitCodes = @(0)
  softwareName   = 'Ultra Defragmenter'
}

Install-ChocolateyInstallPackage @packageArgs

Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" } }
