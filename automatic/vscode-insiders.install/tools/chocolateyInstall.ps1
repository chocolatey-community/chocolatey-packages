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
  url            = 'https://az764295.vo.msecnd.net/insider/bb221a61d29deabd99ee9431736d04f2175cb596/VSCodeSetup-ia32-1.65.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/bb221a61d29deabd99ee9431736d04f2175cb596/VSCodeSetup-x64-1.65.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'ac196ccf327ab58815a16f3ea976d91d0663f2d00f1b10d4cf0bc89741021e9e61465935b97dc0eff0eb12420a0eada9cce794253acba8c25c0baa24d07cfe22'
  checksumType   = 'sha512'
  checksum64     = '8373d29941342c4826e0ee4a07952018b76f5c7c4f0f899aaf0082968ed0220ba65736f2241ec8f5f3b97ce5e04287873a1158478617c7ae4e9a041ab15bb510'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
