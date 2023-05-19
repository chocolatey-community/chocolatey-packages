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
  url            = 'https://az764295.vo.msecnd.net/insider/2d416df5f00253f5ebd60d2f08508a440747fd8d/VSCodeSetup-ia32-1.79.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/2d416df5f00253f5ebd60d2f08508a440747fd8d/VSCodeSetup-x64-1.79.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '0364d6b619db150fd8ef7ec54bc3ad53b831594f06d0ad73cd4827189066d74e1ea454d4cb7ea83e5dd2d9799f884ceca8e3db931fefb97ff1128873f848a760'
  checksumType   = 'sha512'
  checksum64     = '2ae1ba8a75eeddd7ea4245bef37c05ad2b3c560f0d8402454f9183c08919b8e295f553ba3d4ff60934c4ceded5f50709d580d212a12124f6099109ff3c75c913'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
