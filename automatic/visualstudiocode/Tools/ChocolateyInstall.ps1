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
  url            = 'https://az764295.vo.msecnd.net/stable/490ef761b76b3f3b3832eff7a588aac891e5fe80/VSCodeSetup-ia32-1.19.2.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/490ef761b76b3f3b3832eff7a588aac891e5fe80/VSCodeSetup-x64-1.19.2.exe'

  softwareName   = 'Microsoft Visual Studio Code'

  checksum       = '63d038aa72277b31520ff460129b31beac29abc03ffd2eebf000ce8dc0d222cc'
  checksumType   = 'sha256'
  checksum64     = 'ad71e488a9dcb4a28a818a6e31edfdb73aed281869c60a16d15e9bfc1768a0aa'
  checksumType64 = 'sha256'

  silentArgs     = "/verysilent /suppressmsgboxes /mergetasks=""$mergeTasks"" /log=""$env:temp\vscode.log"""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
