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
  url            = 'https://az764295.vo.msecnd.net/insider/7ce1499d9541ba2acf66cd30a9054bd7818a8f80/VSCodeSetup-ia32-1.56.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/7ce1499d9541ba2acf66cd30a9054bd7818a8f80/VSCodeSetup-x64-1.56.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '9d1da4531edde18a33b60765aa6361f0dc67d699385f2828dd86c690ca369da9e951da7c81ac8d59235d33ea3d347edd9f0013de41f7d2b0bf998f92a0b4587b'
  checksumType   = 'sha512'
  checksum64     = '94cdc146cdf7d8682a2dc6c120adf46abb8136428b4208c9e602ef707a1dc74590a5df5028c8cc627b6cc50aa442e27c499c235442fe55f1f243664f011d7c68'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
