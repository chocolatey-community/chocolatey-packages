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
  url            = 'https://az764295.vo.msecnd.net/insider/e790b931385d72cf5669fcefc51cdf65990efa5d/VSCodeSetup-ia32-1.49.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/e790b931385d72cf5669fcefc51cdf65990efa5d/VSCodeSetup-x64-1.49.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'e9e7f4d09c6754e016c088caf71433541dd96319fac835f344b4543b1a789716697995a8769a2cce24a7400a4159d738394db686f63307a7a08c0949e4fef3cd'
  checksumType   = 'sha512'
  checksum64     = '5642ac08826889329a8ccea277a7fbdca93181fceb30fc7685581f460fd738ecfbb9177bdd29a6d6b04faba3b5c21ebfb8dbed188878ade971594e67517175da'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
