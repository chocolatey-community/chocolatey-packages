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
  url            = 'https://az764295.vo.msecnd.net/insider/54d33cf14cf6c0e86880b5b74a5a3628de42bce9/VSCodeSetup-ia32-1.57.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/54d33cf14cf6c0e86880b5b74a5a3628de42bce9/VSCodeSetup-x64-1.57.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'ffe8475a5254903958885a8dc7dc28a2640d028cbb240139695341912480d340a614bf4117b2c7c0db6e7336275423213c4888754023fde2b038f82fb65ff5c7'
  checksumType   = 'sha512'
  checksum64     = 'fea6a89a1031e18351e9573c8dd6f6dfea6abe750fcf128b138188712ed7d2207516b1b09c82c08f7cb3e996c884f8d81217366b5d5404d8f2a9d1c0b669d129'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
