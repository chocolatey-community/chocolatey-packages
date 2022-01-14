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
  url            = 'https://az764295.vo.msecnd.net/insider/0e435cf51d0e45293a94466fc3b1299ba70fa9b1/VSCodeSetup-ia32-1.64.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/0e435cf51d0e45293a94466fc3b1299ba70fa9b1/VSCodeSetup-x64-1.64.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '838fb7f0cd3b25e4fe0a57e79ca77ed5c0d5dec5cccabde9dfad1abe20275008854da87cbc8674e91bf594257aca4c5c92e16a37bb02c604e31065fcac27a7ce'
  checksumType   = 'sha512'
  checksum64     = 'c51f93e656171e2c71047a7bc9b3af1b3f77f16b084eb20c74ecfc3bae0c2d03f1abcca333504fb03cccadfc58ed0b183d50b5e05f9b59637f63fa1e4270a32d'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
