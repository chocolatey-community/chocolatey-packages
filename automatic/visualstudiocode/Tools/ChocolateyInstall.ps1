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
  url            = 'https://az764295.vo.msecnd.net/stable/7c7da59c2333a1306c41e6e7b68d7f0caa7b3d45/VSCodeSetup-ia32-1.23.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/7c7da59c2333a1306c41e6e7b68d7f0caa7b3d45/VSCodeSetup-x64-1.23.0.exe'

  softwareName   = 'Microsoft Visual Studio Code'

  checksum       = 'e169e2d39c0d094417a21d3b159d2bf986e82c9b73abe243ca1e07cf596cfecb'
  checksumType   = 'sha256'
  checksum64     = '3313356942dcb24376008eb3fc1d0580c9799f66bcfd3fb8992bc3699f447421'
  checksumType64 = 'sha256'

  silentArgs     = "/verysilent /suppressmsgboxes /mergetasks=""$mergeTasks"" /log=""$env:temp\vscode.log"""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
