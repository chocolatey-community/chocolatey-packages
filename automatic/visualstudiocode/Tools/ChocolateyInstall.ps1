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
  url            = 'https://az764295.vo.msecnd.net/stable/f88bbf9137d24d36d968ea6b2911786bfe103002/VSCodeSetup-ia32-1.20.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/f88bbf9137d24d36d968ea6b2911786bfe103002/VSCodeSetup-x64-1.20.1.exe'

  softwareName   = 'Microsoft Visual Studio Code'

  checksum       = '6357cd2db735617b4f10f402d6878073c3f4a729f38b9e3f7d376084e25eeb0b'
  checksumType   = 'sha256'
  checksum64     = 'ccd5515e1905f39883bd5135eca598620555320ef16e8639603242675c768a2b'
  checksumType64 = 'sha256'

  silentArgs     = "/verysilent /suppressmsgboxes /mergetasks=""$mergeTasks"" /log=""$env:temp\vscode.log"""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
