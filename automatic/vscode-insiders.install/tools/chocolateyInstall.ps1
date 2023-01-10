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
  url            = 'https://az764295.vo.msecnd.net/insider/e7b5449579249db344d473370d56a5df9446c826/VSCodeSetup-ia32-1.75.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/e7b5449579249db344d473370d56a5df9446c826/VSCodeSetup-x64-1.75.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'c66c6f47dfc553a3b1ab5dc2b5d346d22cd7724b3b6c076a5707b6eb22b9f6946dad31dca31798968ab88b3e1168f517e16497e50116ef26212ca9c9d2c712c8'
  checksumType   = 'sha512'
  checksum64     = 'dfe427f1ee2d5700823b854dc63a9958dcfb80a20c16180aa2b6650b9deeb7db12aaca0cdd0f4d26683c01a3dab5047ca4f71879ac4b219664630e95aaca3537'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
