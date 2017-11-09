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
sleep 1
ps code -ea 0 | kill  #in case gracefull shutdown did not succeed, try hard kill

$packageArgs = @{
  packageName    = 'visualstudiocode'
  fileType       = 'EXE'
  url            = 'https://az764295.vo.msecnd.net/stable/dcee2202709a4f223185514b9275aa4229841aa7/VSCodeSetup-ia32-1.18.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/dcee2202709a4f223185514b9275aa4229841aa7/VSCodeSetup-x64-1.18.0.exe'

  softwareName   = 'Microsoft Visual Studio Code'

  checksum       = 'd3606d7a4e4eb48d70b09582931217241c1b6cbc8d0df4d9a9516a468a69f393'
  checksumType   = 'sha256'
  checksum64     = 'c9d915c9538e0b6ce1205c1cd9cfe7628f537e934d5e1a44ce6a2c5a30345ee3'
  checksumType64 = 'sha256'

  silentArgs     = "/verysilent /suppressmsgboxes /mergetasks=""$mergeTasks"" /log=""$env:temp\vscode.log"""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
