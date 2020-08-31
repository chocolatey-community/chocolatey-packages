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
  url            = 'https://az764295.vo.msecnd.net/insider/f66741dc2b4944e153719bb48bcaa9c565cc40f7/VSCodeSetup-ia32-1.49.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/f66741dc2b4944e153719bb48bcaa9c565cc40f7/VSCodeSetup-x64-1.49.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '6f1d5065f3db8b79436638c9815be662094f6227112fd325ac7401fac91c973b23557d3719bbf17699bf73221f776ee33c0558c2f89f6a577cd935b0c3ff66df'
  checksumType   = 'sha512'
  checksum64     = 'adff68e4afe489a00bdba6c4568405800aac7fa51c8e95ccf0de57927519246d91c9f32980df36566d1af68e441c27a33cfa36408f8dac4ecc4baefcf7ac4cf0'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
