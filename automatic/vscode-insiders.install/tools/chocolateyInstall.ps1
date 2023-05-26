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
  url            = 'https://az764295.vo.msecnd.net/insider/52e56ad19ae0b7cc812f85fa6dcb98928b2ba00d/VSCodeSetup-ia32-1.79.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/52e56ad19ae0b7cc812f85fa6dcb98928b2ba00d/VSCodeSetup-x64-1.79.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '9679304b2e1625d3033f1c778050fd4c4077baf526cbed05ca39ad1bc7c05819ae0717380667aaffa315f2d7ed252c56b72c427206e22c5243537765e4800b7d'
  checksumType   = 'sha512'
  checksum64     = 'a490431070e68a96055ff3a85c96ed868acb0553fe43709ed17a035bf5e8b63d589b2e7d5b45bafa3cdb196dad9673e8b2bd4277e13a328cdc30dfc026e901a9'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
