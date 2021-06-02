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
  url            = 'https://az764295.vo.msecnd.net/insider/217f1a2f60a197807de78af362ecb832100fda96/VSCodeSetup-ia32-1.57.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/217f1a2f60a197807de78af362ecb832100fda96/VSCodeSetup-x64-1.57.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '78064999b8a4ef2607613d1e454f0e2199dbb568b2ba3ec8a242acbd83ab37d434575a02ade0c56f7aa0f26345ff0553297d8d0888b8ce3333c2b18cc6405d68'
  checksumType   = 'sha512'
  checksum64     = '38638eb5c6fffcb5c12c0fc92f116fce74d115c192b9529164ead0fdae8d6e95d59386e04dc50aaf1a9022500be1c62c432501598a0111c2a06e2c89dd04a85e'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
