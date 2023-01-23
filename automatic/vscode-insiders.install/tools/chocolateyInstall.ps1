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
  url            = 'https://vscode.blob.core.windows.net/insider/f1b09237cd400d92987cf7a9681995e8011ef54c/VSCodeSetup-ia32-1.75.0-insider.exe'
  url64bit       = 'https://vscode.blob.core.windows.net/insider/f1b09237cd400d92987cf7a9681995e8011ef54c/VSCodeSetup-x64-1.75.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '425fba7477dea3baad702a4587940bcd2f65b6bb1b3a34bd4ce6e698a7334e7a5d9eb396a2724658e38b49120aef799036b26cc649ae90ca94f4acd0b9a3fdb9'
  checksumType   = 'sha512'
  checksum64     = '56b36dda8d80f4af4906d10bc1126f74aed3263f4924644d2923ca4021cd8c2c55bf6a8a83a0a03714b18ff19e4b473c8ce8b726790e454b475cfa36db9bd8e6'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
