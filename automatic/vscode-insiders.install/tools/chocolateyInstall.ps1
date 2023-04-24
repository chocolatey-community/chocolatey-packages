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
  url            = 'https://az764295.vo.msecnd.net/insider/3a69e153f6c68b2b855fb2f1e5bdb798a16a1ee4/VSCodeSetup-ia32-1.78.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/3a69e153f6c68b2b855fb2f1e5bdb798a16a1ee4/VSCodeSetup-x64-1.78.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '88f6dcde86dc32b5eae674d9eb712d019d84d857a8ab7eba50208011704ce9f003ac8e250cecae560248750740630d3d903fca1e68e7b9f09d990e7951e8eca9'
  checksumType   = 'sha512'
  checksum64     = '7af32bea73eff7db5a534f872326edd1147843452c21bd0ce7d000f98806498a348c6a6202a0125cfb9ea0a01c0ce244fc81408c956abffc75f4187e8b67e9af'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
