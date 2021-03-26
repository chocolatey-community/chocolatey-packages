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
  url            = 'https://az764295.vo.msecnd.net/insider/d06d2f1d6245ce00b1c36a9cd81a9087d225173e/VSCodeSetup-ia32-1.55.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/d06d2f1d6245ce00b1c36a9cd81a9087d225173e/VSCodeSetup-x64-1.55.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '85869dadce9cc1f4c18ca8b748da7870719d12dfa446e778d78ee5d8571220d755ff9bc14a3adc4b4b9786ed769775c690738983e8eac66dde57402c5e9566d3'
  checksumType   = 'sha512'
  checksum64     = '68f21b9215a0ae7739556a4752705aab3d0ef703de96ce0ec2cc3dd6aac7167f0d7e6b5b31ea3825ced57f16b44ad964238c9d0e8cc1256f6564905c6185ec2a'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
