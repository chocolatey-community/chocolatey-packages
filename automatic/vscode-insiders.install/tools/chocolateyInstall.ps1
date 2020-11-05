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
  url            = 'https://az764295.vo.msecnd.net/insider/fcac248b077b55bae4ba5bab613fd6e9156c2f0c/VSCodeSetup-ia32-1.51.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/fcac248b077b55bae4ba5bab613fd6e9156c2f0c/VSCodeSetup-x64-1.51.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '041d25a1e009ba60052c194aa3ec14532c371563e1baf282df9c5d74d8421124a488671c7a1339c70a37f3b4104a8a4c1a73ce7bf7a3096b1fe56c6d0306615e'
  checksumType   = 'sha512'
  checksum64     = 'bd4ef8be44a33c324a93e44447be20159c10737de7983ef53cf4b4f1079f945b8a4dee6edbd1c0a62aa20abbc00672668968160cd4441c1cd4338146946a2a4f'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
