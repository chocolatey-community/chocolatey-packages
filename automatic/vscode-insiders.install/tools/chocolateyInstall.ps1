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
  url            = 'https://az764295.vo.msecnd.net/insider/bb16786cff3d231facbdcee90741ac25fcffd3ac/VSCodeSetup-ia32-1.51.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/bb16786cff3d231facbdcee90741ac25fcffd3ac/VSCodeSetup-x64-1.51.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'd3cb358a33023ab2a0c1e762a7aa07a670db4c063fde41b717fbed96bb95898b7d03d4c3d20025aec40fe77b2e20b57da38368c380fa78ac80e09414ef9e56cd'
  checksumType   = 'sha512'
  checksum64     = '1530d5b25fe3f7ca9549cc7921c173dae702bcb0956bc62d1e64d6817b61ed4906420420f54e106144430f3a3b13ec3db8a1d97b6936586f09a781f818994147'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
