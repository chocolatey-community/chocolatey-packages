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
  url            = 'https://az764295.vo.msecnd.net/insider/e4b1e9ac57ab3cc942ab9bff09967bf3238a7910/VSCodeSetup-ia32-1.55.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/e4b1e9ac57ab3cc942ab9bff09967bf3238a7910/VSCodeSetup-x64-1.55.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '7bae9f23d929b8075f621f9e6319228ef0481d0e3480c45ab5ad2dd3bfa7015d0dbd79dad3e2f2d3a7a507f617f860f502e4a39c2567c61ffef67cd33a8e3776'
  checksumType   = 'sha512'
  checksum64     = 'bf213c1822771f0b8baf3643d0dea1adfc07a9a9491a9706a0a6f73c7e9fd7d68455c12812e62d1c164e96c3243eecf51ea3543e6e2357f4f320a63ef5655b72'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
