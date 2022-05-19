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
  url            = 'https://az764295.vo.msecnd.net/insider/ba2dd825803b5f95d5dcce927afc3a4882ed0f84/VSCodeSetup-ia32-1.68.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/ba2dd825803b5f95d5dcce927afc3a4882ed0f84/VSCodeSetup-x64-1.68.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'cfc6a1fd89317c02629efce27acc1a3167537514ab468fea4b25834c90793097b11048f6b05046edb2674abce54ec58c4a67efa57e4666b52edd153bdddbea47'
  checksumType   = 'sha512'
  checksum64     = 'a60f590da0a614affd479afa8beac370a4ab879dda745c8453b69d8e17345a6be9df0432ffab8faecb46739094dce39551129536e66b0b7bd3f448016ce55545'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
