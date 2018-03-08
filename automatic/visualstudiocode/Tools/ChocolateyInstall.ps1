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
  url            = 'https://az764295.vo.msecnd.net/stable/9a199d77c82fcb82f39c68bb33c614af01c111ba/VSCodeSetup-ia32-1.21.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/9a199d77c82fcb82f39c68bb33c614af01c111ba/VSCodeSetup-x64-1.21.0.exe'

  softwareName   = 'Microsoft Visual Studio Code'

  checksum       = '394f1e5d2aebd24f0bac0c210a784318a848fdf375148757087347d6f9104a0f'
  checksumType   = 'sha256'
  checksum64     = '07fe0d2433176fdf626a8a011bf6155d42b05124c8188540b6d7ad186778665c'
  checksumType64 = 'sha256'

  silentArgs     = "/verysilent /suppressmsgboxes /mergetasks=""$mergeTasks"" /log=""$env:temp\vscode.log"""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
