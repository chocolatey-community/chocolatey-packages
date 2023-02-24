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
  url            = 'https://az764295.vo.msecnd.net/insider/720985f2c68cadb5e375d9ec671476c548f61769/VSCodeSetup-ia32-1.76.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/720985f2c68cadb5e375d9ec671476c548f61769/VSCodeSetup-x64-1.76.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '05d6966a4ab6b7674b92723c4969ac3352e3b87c45bb32db01d45acb677779350125017fb0ed9fcff9bb7e1e09a8767f1910a74e09e786bb489dce5a83b106ae'
  checksumType   = 'sha512'
  checksum64     = '35ae91430fc238a6727169aa7193ad2f78e765f45b8d2396906963c1fad97f5390b078c461d2a7f756c5b100d24c395eedd3a6605d0a63fc7b982a2edb8a47e2'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
