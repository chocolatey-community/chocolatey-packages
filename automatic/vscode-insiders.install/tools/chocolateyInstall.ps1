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
  url            = 'https://az764295.vo.msecnd.net/insider/b614fb5db84b3ac07fc3e8b12c69c1dd581924ce/VSCodeSetup-ia32-1.63.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/b614fb5db84b3ac07fc3e8b12c69c1dd581924ce/VSCodeSetup-x64-1.63.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'd2ef96eeefb9c0024f263b7ab7a01ce8a0d1ab87d9d617cc3e95395dcc0473e741849ba4cd8e48629fe445eb815c9dcb8d773788586638e4d9bc6ee103d8f76b'
  checksumType   = 'sha512'
  checksum64     = '6f303ec660fbfb9075f860d500a9445bc7e10b7eaf3eb9a94de33896c40d073167cce3b6a6ad24f83825229d57c37d4a40215dd97cb44cf6444c817ac7bca82c'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
