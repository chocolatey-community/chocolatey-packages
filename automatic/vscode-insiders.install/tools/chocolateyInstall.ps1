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
  url            = 'https://az764295.vo.msecnd.net/insider/4bbec283c36a51cf80f9b77c7a81c140a76a363b/VSCodeSetup-ia32-1.62.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/4bbec283c36a51cf80f9b77c7a81c140a76a363b/VSCodeSetup-x64-1.62.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'db812eb7c64f196778ac1499f9ec7cecff4d46e5e7a241a0989686c0440311def933eb4cd1ea5677f66847e945d755530edf7f09185cbbc51ce78d0645428318'
  checksumType   = 'sha512'
  checksum64     = 'a08d645ca0905eea38d28ea519113017229e57f6e08efed39fefdd40f488c63577b043552445069a7aa8e63fbffac2f0adef718e2672958b8950d73b3e374b73'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
