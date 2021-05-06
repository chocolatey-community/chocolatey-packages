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
  url            = 'https://az764295.vo.msecnd.net/insider/fe23c2041f848d6c2f6bd27875112a37bcc82f84/VSCodeSetup-ia32-1.57.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/fe23c2041f848d6c2f6bd27875112a37bcc82f84/VSCodeSetup-x64-1.57.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '44a3f306201947da3651074643d93f371fe38eb5a745b695b76754b473f62fae9a2744db7520c670c98592e0f53522f26d032cd22d5bf6c875db0ae43b9cab79'
  checksumType   = 'sha512'
  checksum64     = 'fba9fd388dbebdd1469be3bf6342d8362514a817c4b59bfcf2157fc63211c8301e74f3b2d7e4cfee692ef934e4173a334faf55c4b21e3a95b0fe33fc0160f8c4'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
