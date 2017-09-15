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
  url            = 'https://az764295.vo.msecnd.net/stable/27492b6bf3acb0775d82d2f87b25a93490673c6d/VSCodeSetup-ia32-1.16.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/27492b6bf3acb0775d82d2f87b25a93490673c6d/VSCodeSetup-x64-1.16.1.exe'
 
  softwareName   = 'Microsoft Visual Studio Code'
 
  checksum       = '49896ed32d9c9e27dfa0f376f6866c1cbc4f2a30ae6b622325eaffdfd9be21b2'
  checksumType   = 'sha256'
  checksum64     = '62b6f28d0bd02c0193389fb1b716fed1a2e8d5aea7d38ed39c70e2c2d0b20797'
  checksumType64 = 'sha256'
 
  silentArgs     = "/verysilent /suppressmsgboxes /mergetasks=$mergeTasks /log=""$env:temp\vscode.log"""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
