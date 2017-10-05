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
  url            = 'https://az764295.vo.msecnd.net/stable/be377c0faf7574a59f84940f593a6849f12e4de7/VSCodeSetup-ia32-1.17.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/be377c0faf7574a59f84940f593a6849f12e4de7/VSCodeSetup-x64-1.17.0.exe'
 
  softwareName   = 'Microsoft Visual Studio Code'
 
  checksum       = '90876a8f0423d30112675be4e509acba5f27df38d8ee9112267f1c5621275660'
  checksumType   = 'sha256'
  checksum64     = '2010fd6dd7c1b6858de84b3aa49f177b697e5b4bce436544f338c223be4be0e2'
  checksumType64 = 'sha256'
 
  silentArgs     = "/verysilent /suppressmsgboxes /mergetasks=$mergeTasks /log=""$env:temp\vscode.log"""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
