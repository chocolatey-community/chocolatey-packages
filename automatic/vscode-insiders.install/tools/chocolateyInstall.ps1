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
  url            = 'https://az764295.vo.msecnd.net/insider/d18d093403b12a65350c58a7b0d5771cc1f42aba/VSCodeSetup-ia32-1.63.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/d18d093403b12a65350c58a7b0d5771cc1f42aba/VSCodeSetup-x64-1.63.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '7b711579b6afcde415204f9bb9ccb3581e2c9281d57cb7d7b1475fab460413a9780098df6db9bd8210b81b84182d91104f49969eb9d94c781fda72217c83307d'
  checksumType   = 'sha512'
  checksum64     = '09c14ab8015cf3d2538d39db9029bf3c7f465267f256ef3d6901a2d6fb1b060484a58f07f3da128226e2dbc766d0204bdf447dca5a369a1af1a64b504c6dc66b'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
