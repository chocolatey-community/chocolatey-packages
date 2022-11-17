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
  url            = 'https://az764295.vo.msecnd.net/insider/d9a70c4236a8bde4fe7435df3ecdd333c7bc939c/VSCodeSetup-ia32-1.74.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/d9a70c4236a8bde4fe7435df3ecdd333c7bc939c/VSCodeSetup-x64-1.74.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'a45c8ef5e94c6807083b188050439a1f4e5bb16d68ba2341c232f977d7d2bd9500a4ad082dc06decdf1592cc2ad3ada1b5653faa2a86a10db904bbea260568a6'
  checksumType   = 'sha512'
  checksum64     = 'f4068a076ec69a08878293fa0904ec090cca55338b850297d69f5b08855bad016af7d9f75c9c054d4bcd74d0c435a158717e95a085c5d3d87c82bddf3441daf5'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
