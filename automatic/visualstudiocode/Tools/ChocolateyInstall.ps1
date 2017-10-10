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

ps code -ea 0 | % { $_.CloseMainWindow() | Out-Null }

$packageArgs = @{
  packageName    = 'visualstudiocode'
  fileType       = 'EXE'
  url            = 'https://az764295.vo.msecnd.net/stable/1e9d36539b0ae51ac09b9d4673ebea4e447e5353/VSCodeSetup-ia32-1.17.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/1e9d36539b0ae51ac09b9d4673ebea4e447e5353/VSCodeSetup-x64-1.17.1.exe'
 
  softwareName   = 'Microsoft Visual Studio Code'
 
  checksum       = 'de37c19189bcebb0812ac464fe8d80dd29c3d4f479d2394e5653c75f7ff309ba'
  checksumType   = 'sha256'
  checksum64     = '945271da262bcaf6604885ed7da1cecc9abe2c5ed5d336f8cd9700013d0d5cf7'
  checksumType64 = 'sha256'
 
  silentArgs     = "/verysilent /suppressmsgboxes /mergetasks=$mergeTasks /log=""$env:temp\vscode.log"""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
