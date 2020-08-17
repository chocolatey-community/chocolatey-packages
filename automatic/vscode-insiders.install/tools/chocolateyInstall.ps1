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
  url            = 'https://az764295.vo.msecnd.net/insider/652a432f59f54733bf17b79c9f2b7a925971a53d/VSCodeSetup-ia32-1.49.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/652a432f59f54733bf17b79c9f2b7a925971a53d/VSCodeSetup-x64-1.49.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '9085c91d6f51a3ee925d1f9fb9d6be2d402a0b9281eccbb6d26096d93f742b903d9d6dfeb2fd19f863b9872553f556eb00e4cb543ecf41ee1bb1a79f8a3d0f89'
  checksumType   = 'sha512'
  checksum64     = '490e71dd08817ce02032e5042bb1c327d8302d47009ced581a44210c971a9efc916466c4156df334c1daf807e8db80e40821f9a4928b78bdac054f9b508e7da3'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
