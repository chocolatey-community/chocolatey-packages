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
  url            = 'https://az764295.vo.msecnd.net/insider/173f4bea73601a31859372b409cac2c20fa91194/VSCodeSetup-ia32-1.69.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/173f4bea73601a31859372b409cac2c20fa91194/VSCodeSetup-x64-1.69.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '619d37b2c90f6d60fad12e14257cf4d8d6bb9aaf5aef283a380396e053fd0bebb12bf1ae9ef63641ca8fdea97e66ab97e78ed3885992efff77f7f44f5dfd72f7'
  checksumType   = 'sha512'
  checksum64     = 'bb2617692d9cb63ba247898e5a44ae42c067bae4d6de1f70948be1c93b7c5e4f86d7f64afc225ca55e12dffcae2849f2bb50204fefeb2735879fcdc805e975e0'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
