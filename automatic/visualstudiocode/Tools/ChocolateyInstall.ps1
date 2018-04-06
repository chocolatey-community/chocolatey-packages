$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

$pp = Get-PackageParameters
$mergeTasks = "!runCode"
$mergeTasks += ', ' + '!'*$pp.NoDesktopIcon        + 'desktopicon'
$mergeTasks += ', ' + '!'*$pp.NoQuicklaunchIcon    + 'quicklaunchicon'
$mergeTasks += ', ' + '!'*$pp.NoContextMenuFiles   + 'addcontextmenufiles'
$mergeTasks += ', ' + '!'*$pp.NoContextMenuFolders + 'addcontextmenufolders'
$mergeTasks += ', ' + '!'*$pp.DontAddToPath        + 'addtopath'
Write-Host "Merge Tasks: `n$mergeTasks"

Get-Process code -ea 0 | ForEach-Object { $_.CloseMainWindow() | Out-Null }
Start-Sleep 1
Get-Process code -ea 0 | Stop-Process  #in case gracefull shutdown did not succeed, try hard kill

$packageArgs = @{
  packageName    = 'visualstudiocode'
  fileType       = 'EXE'
  url            = 'https://az764295.vo.msecnd.net/stable/950b8b0d37a9b7061b6f0d291837ccc4015f5ecd/VSCodeSetup-ia32-1.22.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/950b8b0d37a9b7061b6f0d291837ccc4015f5ecd/VSCodeSetup-x64-1.22.1.exe'

  softwareName   = 'Microsoft Visual Studio Code'

  checksum       = '0dd0e5e894adc73b1fbc730c8d67597ecb25c5e685e1a2c8d41e4b459b3842d9'
  checksumType   = 'sha256'
  checksum64     = '2ea81dddde7e2da452bba97ae239a9579b261c189f57fac246f8c06c1fe641a5'
  checksumType64 = 'sha256'

  silentArgs     = "/verysilent /suppressmsgboxes /mergetasks=""$mergeTasks"" /log=""$env:temp\vscode.log"""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
