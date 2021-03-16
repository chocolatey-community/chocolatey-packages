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
  url            = 'https://az764295.vo.msecnd.net/insider/892a1083cb2b9b3987ff7edc85376b5d9764433d/VSCodeSetup-ia32-1.55.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/892a1083cb2b9b3987ff7edc85376b5d9764433d/VSCodeSetup-x64-1.55.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'e77ef06e87ddfbbcc638f6ae625855f5a2cc5a88191778618cb4ae2444112b5624bfb9561f3df2ef8263af7f415d21a85b8bd856fcdb49c39b39314dfb5d5961'
  checksumType   = 'sha512'
  checksum64     = '75dd3e126088d3d2c71aafbd7848747c910675bbfb2db5901bbe0208f699121ac6d71a22aeea411a73fc04fe28227314a1531fa351065d142df7e47df23182c7'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
