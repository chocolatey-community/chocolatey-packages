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
  url            = 'https://az764295.vo.msecnd.net/insider/c1bca6d7cc2c5f71ae04deda90c0cf50819ffde4/VSCodeSetup-ia32-1.80.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/c1bca6d7cc2c5f71ae04deda90c0cf50819ffde4/VSCodeSetup-x64-1.80.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '09c0feaf4d0a5a25edf366263fc8e77e4c591a92114e2f709ac520e0598b06fe28292308d547b9cc11f1b288abb1e98c4650fe012eff472d5776a6fcae58f45a'
  checksumType   = 'sha512'
  checksum64     = 'e1180baf187a5579441fbcbadb416fae72696278b1ffcb7f96630e7ca20557dbb36c7c1a22bc2629a4db39a9dcb0640ac1b04a3138eefa158f301bbc603f91f7'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
