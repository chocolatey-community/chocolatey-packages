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
  url            = 'https://az764295.vo.msecnd.net/stable/c63189deaa8e620f650cc28792b8f5f3363f2c5b/VSCodeSetup-ia32-1.20.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/c63189deaa8e620f650cc28792b8f5f3363f2c5b/VSCodeSetup-x64-1.20.0.exe'

  softwareName   = 'Microsoft Visual Studio Code'

  checksum       = 'ee89f176670c238504cb04048bf2ea55181f4b713914d8c840f25e90afb5a12f'
  checksumType   = 'sha256'
  checksum64     = '8db2348c149f2f789df048c46bd400b80df22c43ee3c7848cc92c2a71e0bc9c2'
  checksumType64 = 'sha256'

  silentArgs     = "/verysilent /suppressmsgboxes /mergetasks=""$mergeTasks"" /log=""$env:temp\vscode.log"""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
