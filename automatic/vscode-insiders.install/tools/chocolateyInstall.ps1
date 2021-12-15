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
  url            = 'https://az764295.vo.msecnd.net/insider/b823936907f86ded04a152a4af202d0fc8423522/VSCodeSetup-ia32-1.64.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/b823936907f86ded04a152a4af202d0fc8423522/VSCodeSetup-x64-1.64.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '299a95595ca4dd0f5f0f75502804dce3af9aeee3fc6ddc5176fea269b07b0b2ec7957ced6419e6f0bbf472e970282a58d68b259dc43df2d729fc570f8b3dbc03'
  checksumType   = 'sha512'
  checksum64     = '5dde5797f09d1c5792b943dd5e882191c403ff5d7a2bfa6ef752f0343f662b06dc8a0299b5ac6f92ee9e86596a6de58ce59c901be59e0f5e477b6945231db0fd'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
