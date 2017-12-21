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
  url            = 'https://az764295.vo.msecnd.net/stable/0759f77bb8d86658bc935a10a64f6182c5a1eeba/VSCodeSetup-ia32-1.19.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/0759f77bb8d86658bc935a10a64f6182c5a1eeba/VSCodeSetup-x64-1.19.1.exe'

  softwareName   = 'Microsoft Visual Studio Code'

  checksum       = '216784a240f6f385a2ee8a993517b9d093579e1f3a3ba051a7c8789c65a92aac'
  checksumType   = 'sha256'
  checksum64     = '7bb2b2838b18de7ab384b511fb70773a7325e74e12946d4f55b6570943489429'
  checksumType64 = 'sha256'

  silentArgs     = "/verysilent /suppressmsgboxes /mergetasks=""$mergeTasks"" /log=""$env:temp\vscode.log"""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
