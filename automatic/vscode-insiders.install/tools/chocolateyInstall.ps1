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
  url            = 'https://az764295.vo.msecnd.net/insider/42b1f560e3badc792056a1021094fbf859588d8d/VSCodeSetup-ia32-1.68.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/42b1f560e3badc792056a1021094fbf859588d8d/VSCodeSetup-x64-1.68.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '89bcf67338be366c88a5f03276ddcfba10bd0c7528204ce0bdf94c2f11eda4a66150c9a99fa7a019cf96c72c8456b68d97eef0da8c37fd305cc337e27997c290'
  checksumType   = 'sha512'
  checksum64     = '784bd5d3715839f6b92b019dda4d86d65e33a1f422d95d31ac532a3d1a1004a861758709a999a7f7e70040783567deb249b373bd467558c84571289577df9377'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
