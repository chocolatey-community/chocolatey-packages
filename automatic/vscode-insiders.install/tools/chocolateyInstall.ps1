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
  url            = 'https://az764295.vo.msecnd.net/insider/b7730c807c1e0fdacdcc91a854bb963715b2a89b/VSCodeSetup-ia32-1.65.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/b7730c807c1e0fdacdcc91a854bb963715b2a89b/VSCodeSetup-x64-1.65.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '0c5b8a932b504bf764e8a62c23729c51296a55ce3414f8d03d942e30ec669c90e02e9645cb3d115d9ebd223da134a2aff1c8bd69c1366329eb9d7bce74c2e4be'
  checksumType   = 'sha512'
  checksum64     = '48857eb517c6478d8f84232fc75813b77dbf584ac1c9e486a1ed19098f758e2c4f856a1c1eacf239b81b73102625cc75f5ab73c58e3054f717b66675f12e5e2f'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
