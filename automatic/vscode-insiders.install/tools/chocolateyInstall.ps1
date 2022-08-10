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
  url            = 'https://az764295.vo.msecnd.net/insider/dced70bbf36d3c53c08e791da1791ac7fc42519b/VSCodeSetup-ia32-1.71.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/dced70bbf36d3c53c08e791da1791ac7fc42519b/VSCodeSetup-x64-1.71.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'ca62f0503dafcaf15e40b46248a0f3d1d022082bf7017eb75470868614a4ef71fed05c0c4583b0c7ece4f338d86eca4bb6049e8c697caa4abb1f9d118924678e'
  checksumType   = 'sha512'
  checksum64     = '9b01517de517d1c135f682e1f0b57e6f469b105ea09e43b8b6bfa8d2746dda6258a515e85f96654c3e9caf91e71a1bdeaf587d41f399f843207e97b29d5f97d9'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
