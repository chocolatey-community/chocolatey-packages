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
  url            = 'https://az764295.vo.msecnd.net/insider/3e5c7e2c570a729e664253baceaf443b69e82da6/VSCodeSetup-ia32-1.66.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/3e5c7e2c570a729e664253baceaf443b69e82da6/VSCodeSetup-x64-1.66.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'fb0ff5d64405d3a1a3e04da284bee8b78d95e80156685b68809f3954ebf312cad753f893ab19b67af11369188110ffb550989496f3410b832b7af1f3eec99af9'
  checksumType   = 'sha512'
  checksum64     = 'bd258ac9ee8f3505a1ced132b515764832003a2d70e432576eb38ee555c81758c0ed552deb0b61d9935c3c1b2ae03a1d0084f1a9e283057fed01a2a097836dd2'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
