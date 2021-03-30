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
  url            = 'https://az764295.vo.msecnd.net/insider/c71be15869a673c5ed7bfd3fe171757d2ba48142/VSCodeSetup-ia32-1.55.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/c71be15869a673c5ed7bfd3fe171757d2ba48142/VSCodeSetup-x64-1.55.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '69bbbdafa3ec953e145df5b26d28d2470f8cacdcd19c2e07d00f1d853a0fa93593c2f2bf465b92765384475221391a7214607cdbcf835c9239923786b9450cdc'
  checksumType   = 'sha512'
  checksum64     = '764e455ecedbc4bd84e49d7ee5c260438e497ea5e7d75b3be1ac3803f7c308e691f28e06036a424e71bd20fd554926c2a4b52765ace14c06a50032f92c7344cc'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
