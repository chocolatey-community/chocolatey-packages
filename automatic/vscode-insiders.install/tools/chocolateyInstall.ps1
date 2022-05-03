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
  url            = 'https://az764295.vo.msecnd.net/insider/d31c2035e4444d7ecc6b04efc0759ad99fb9242d/VSCodeSetup-ia32-1.67.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/d31c2035e4444d7ecc6b04efc0759ad99fb9242d/VSCodeSetup-x64-1.67.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '52df9d6c90127ff1d1152a6177b0052bb8e9e1fac1d72f496f9703ecdf21ad1cc3ab6b798dfd86db80863d0f1faeed71a3e5da7749e84bb5c918b6184aaccdd6'
  checksumType   = 'sha512'
  checksum64     = 'b524ced0d89bd0ebb2fc0ce6617c716d09eda8e12afa144799bf838684bd3f7191d46a56f76de9f81a5e424e30f7027c2cab18e12339d9ac8a3cef651fdc9341'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
