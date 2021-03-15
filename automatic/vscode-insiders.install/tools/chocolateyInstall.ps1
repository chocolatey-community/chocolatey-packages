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
  url            = 'https://az764295.vo.msecnd.net/insider/84fe402d655e029eb1a5c04e675bf64788fa7fcf/VSCodeSetup-ia32-1.55.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/84fe402d655e029eb1a5c04e675bf64788fa7fcf/VSCodeSetup-x64-1.55.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '46fd68d8ce8d52d3c1b8758f2791aedfd5c50c16335542aab42c3fc8ffec3b60b350200e671d99833da0ed3c0bc93a2ec38b16202d9433ff17c0f6dcb26ce55c'
  checksumType   = 'sha512'
  checksum64     = '304a67b621759cd62e4065557b84c32dcff30fb113aee8b28a75d63b90fc47bcb6da0c9dd3a32e4df6c96c96780b49d13429fc1fc89421dbd19a9f3df09e18b1'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
