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
  url            = 'https://az764295.vo.msecnd.net/insider/92da9481c0904c6adfe372c12da3b7748d74bdcb/VSCodeSetup-ia32-1.76.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/92da9481c0904c6adfe372c12da3b7748d74bdcb/VSCodeSetup-x64-1.76.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '7463cd089155f274a4520af1327f47a8085186a748e7d501a3e774d9d59ae5cf31da08c4886088ca592ab2dfdcd90f88578a542ec41665615f7e3ec6b56400c4'
  checksumType   = 'sha512'
  checksum64     = 'ad86368498b5dcb0b90ef8baef34c622bb1e7f95ff4ced446c20b0394f3474b1446b5dd1c216b39e67d7f9a99220cdad5304bcb6791730aef9801ef32dfb2640'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
