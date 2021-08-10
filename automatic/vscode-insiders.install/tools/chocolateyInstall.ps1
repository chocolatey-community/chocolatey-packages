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
  url            = 'https://az764295.vo.msecnd.net/insider/71b299184f7908491345aec5e231599c3ae8753b/VSCodeSetup-ia32-1.60.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/71b299184f7908491345aec5e231599c3ae8753b/VSCodeSetup-x64-1.60.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '6bce28efb2d81f06995d7a156752038414f18128eacb4c67cba580fae8272060369b23825082b49d826521e23a170a7e8acfe597fdd6bdeabe8cc2de422de3e0'
  checksumType   = 'sha512'
  checksum64     = '0c90766b9a3ba2309c1e28a4788cce052f62729a9146fe9795248c0540c81a5a83bfe5de984c383f8d867af78b80d446b248213600aa85407f511497e7cb3522'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
