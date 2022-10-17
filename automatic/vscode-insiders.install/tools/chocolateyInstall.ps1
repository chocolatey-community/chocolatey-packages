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
  url            = 'https://az764295.vo.msecnd.net/insider/6455bf1608dfa1b955717f66295f0f9200db0f73/VSCodeSetup-ia32-1.73.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/6455bf1608dfa1b955717f66295f0f9200db0f73/VSCodeSetup-x64-1.73.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '3a9fd1359bbd2c8596aca07abe2ce80aef20dda671853c2599dd8a548b59d6f0bad3b6221fd165e0b48df3eabeb193c66306e1571e4292e1b91d8803a47bd003'
  checksumType   = 'sha512'
  checksum64     = '64d8ea20275af90d600e716e3a425165b166691a05a41e736e848836db6c18d745d5f16f1bc52006a8a149d0a53360f65af5bf77b9a7cb40edfcfa2d1cd38286'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
