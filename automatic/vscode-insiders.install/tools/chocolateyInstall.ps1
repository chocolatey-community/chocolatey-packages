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
  url            = 'https://az764295.vo.msecnd.net/insider/db0525ff4ba814780e901a5b9e399aaf596b9b20/VSCodeSetup-ia32-1.66.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/db0525ff4ba814780e901a5b9e399aaf596b9b20/VSCodeSetup-x64-1.66.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '1cdf6b2464e43d29062e7e8e73941ca38cfbf2462a38f74b9e1b589212dc963dfd973c6a8b5c6d738fe08bc73fb022dd82292fe66472d790fba6b8e2e067795a'
  checksumType   = 'sha512'
  checksum64     = '2a8daa0499f871a359831a0dec428a5565a493dbd393a3ed9b37e5b6ba38b13d92a17fdc04019b2f2b02f29fc41cdd9612606c6fae638a6449f1110ee4eb3357'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
