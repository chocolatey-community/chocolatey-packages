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
  url            = 'https://az764295.vo.msecnd.net/insider/e437d424c5e6de97632f5513229c7ebc2cf27a32/VSCodeSetup-ia32-1.59.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/e437d424c5e6de97632f5513229c7ebc2cf27a32/VSCodeSetup-x64-1.59.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'bb1e0529bb25cae69784fd3dfd674919fa299854b1fd4d004a567e009e2d8f0a923dba9af1280b903dc94867284cac4989f63ca4f3caaa847d71270564a64df3'
  checksumType   = 'sha512'
  checksum64     = '4ea1e3feb48e21a9a7bffb58a6e1d8cec2cb5d725bfd2f9c80e4e611293ad76ceb8aac588efeb9391ffc49cff589c106789f552c424e1cf46125881fe5e8b6bc'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
