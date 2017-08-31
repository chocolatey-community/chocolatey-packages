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
  unzipLocation  = $toolsDir
  fileType       = 'EXE'
  url            = $url32
  url64bit       = $url64
 
  softwareName   = 'Microsoft Visual Studio Code'
 
  checksum       = ''
  checksumType   = 'sha256'
  checksum64     = ''
  checksumType64 = 'sha256'
 
  silentArgs     = "/verysilent /suppressmsgboxes /mergetasks=$mergeTasks /log=""$env:temp\vscode.log"""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
