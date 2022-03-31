$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

Close-VSCodeInsiders

$pp = Get-PackageParameters
function Get-MergeTasks {
  $t = "!runCode"
  $t += ', ' + '!' * $pp.NoDesktopIcon + 'desktopicon'
  $t += ', ' + '!' * $pp.NoQuicklaunchIcon + 'quicklaunchicon'
  $t += ', ' + '!' * $pp.NoContextMenuFiles + 'addcontextmenufiles'
  $t += ', ' + '!' * $pp.NoContextMenuFolders + 'addcontextmenufolders'
  $t += ', ' + '!' * $pp.DontAssociateWithFiles + 'associatewithfiles'
  $t += ', ' + '!' * $pp.DontAddToPath + 'addtopath'

  Write-Host "Merge Tasks: $t"
  $t
}

$packageArgs = @{
  packageName    = "$env:ChocolateyPackageName"
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/insider/95e8ecaa65bf2d790a4e3b586e843435fc5c0f77/VSCodeSetup-ia32-1.67.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/95e8ecaa65bf2d790a4e3b586e843435fc5c0f77/VSCodeSetup-x64-1.67.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '7f2acd3d3427ed5a53895b75b11e0ef4391979c8c962d3db7050080103abd2acceb77334d15dba4d11ea5bd2c4b7090b1a937959e54724e4b1866e7ab7a47013'
  checksumType   = 'sha512'
  checksum64     = '551fa05e38ea7d629759d69aa5dca4c925ba86ead07a88f4300d16561e1e5941888c7d2e2e71369d3303496429877cb9ccc9fdc25ea07d40f9df490742c5c7c7'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
