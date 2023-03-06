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
  url            = 'https://az764295.vo.msecnd.net/insider/0cab3cc3cbe4d4ac2cbf30e8c30351d9db6dcfb4/VSCodeSetup-ia32-1.77.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/0cab3cc3cbe4d4ac2cbf30e8c30351d9db6dcfb4/VSCodeSetup-x64-1.77.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '8f1dac61f3ea6eab67c94d7ee3a77c408c6c4d0f8a79b4bc58e7e4eafdbaa7f4ee2196a21cf4e7f534991075961631d5776420844712601aa91453ae1283f680'
  checksumType   = 'sha512'
  checksum64     = '7c4e1ef52fc9925a921d61c83adf7c65d11134f77646be49831300fae653736f95105f75c2536242f3bffa782485f7954b12b8e15d2418d59cb849d62d951205'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
