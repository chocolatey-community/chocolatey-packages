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
  url            = 'https://az764295.vo.msecnd.net/insider/a522f37e37735c0cbe7244680250ef73d9054dd1/VSCodeSetup-ia32-1.51.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/a522f37e37735c0cbe7244680250ef73d9054dd1/VSCodeSetup-x64-1.51.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'a16e76e23c1a1d4eb54be28909079d7c7f82425e1b1b5c0960f75a1fb4c0e342e742a22d56e3b0d93fcf6399d3a9ddc11b8bbdd05b4f4e2cad5149b646bf3fb0'
  checksumType   = 'sha512'
  checksum64     = '81a9628ae065bdcdd5e62b4d352713f8797cf8965e409585b733778513cd1cff47633fdc3733cba5535d2d66b93153d972866206ad82a9ff384e8817663f175d'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
