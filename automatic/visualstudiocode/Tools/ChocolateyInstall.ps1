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
  url            = 'https://az764295.vo.msecnd.net/stable/816be6780ca8bd0ab80314e11478c48c70d09383/VSCodeSetup-ia32-1.19.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/816be6780ca8bd0ab80314e11478c48c70d09383/VSCodeSetup-x64-1.19.0.exe'

  softwareName   = 'Microsoft Visual Studio Code'

  checksum       = '89de80cd13edcca2e75b99a2b408ef2eef08b3e47ab3551221f8fe9f907ff691'
  checksumType   = 'sha256'
  checksum64     = '4801510041c8024c21ca5d282ed9f567225579c9571a9ed57af8f3c3165baa03'
  checksumType64 = 'sha256'

  silentArgs     = "/verysilent /suppressmsgboxes /mergetasks=""$mergeTasks"" /log=""$env:temp\vscode.log"""
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
