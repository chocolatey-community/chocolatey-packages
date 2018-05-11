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
  url            = 'https://az764295.vo.msecnd.net/stable/d0182c3417d225529c6d5ad24b7572815d0de9ac/VSCodeSetup-ia32-1.23.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/d0182c3417d225529c6d5ad24b7572815d0de9ac/VSCodeSetup-x64-1.23.1.exe'

  softwareName   = 'Microsoft Visual Studio Code'

  checksum       = '0c8cfd65f9303ddbfa76277123eacc869b7e33c47642f5a33d3de5edb661a98a'
  checksumType   = 'sha256'
  checksum64     = 'e93b72baedf6fc1234e1da751b03d67631e150f4d93573db83c9f205b632e0bd'
  checksumType64 = 'sha256'

  silentArgs     = "/verysilent /suppressmsgboxes /mergetasks=""$mergeTasks"" /log=""$env:temp\vscode.log"""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
