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
  url            = 'https://az764295.vo.msecnd.net/insider/3a79384dbf81dc6eba781ff669996d2042ca3b72/VSCodeSetup-ia32-1.63.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/3a79384dbf81dc6eba781ff669996d2042ca3b72/VSCodeSetup-x64-1.63.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '653467c112d07704fec9269d7a2619d8d94fb75a24247fd39b17fa267512212f552db1b5631e76758ee0789e29a25c6590733aefc2a4a8a39a9682fc767d22b3'
  checksumType   = 'sha512'
  checksum64     = 'f641d7417476fd31da1b2c23a9d4092cfb737462e813b8f0c9d4941e239c39234e4160fc79fa0f0133ff0472395501241228f0ed4e0983ebf8ed42b0cb6fc35e'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
