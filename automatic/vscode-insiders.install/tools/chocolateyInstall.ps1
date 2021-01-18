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
  url            = 'https://az764295.vo.msecnd.net/insider/eaa959d34b863dec932077d94daece22504a396b/VSCodeSetup-ia32-1.53.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/eaa959d34b863dec932077d94daece22504a396b/VSCodeSetup-x64-1.53.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'bc67bbe3548cf4cfbdc736a6ca0503407c530b6bd6b6408bd82bd97f876d913669df8c70fce16cd65c550ef7e31524a656c7f08e863a538a51fb3ebca7fe0a7d'
  checksumType   = 'sha512'
  checksum64     = '9ed74189af61f3241ee1713c30eaac86570bb876376614f3aec5cc7f7ca24d7b9a10476d15b73e516fc08d3e12ca7034ce24e9e2cfd3bf3741f3e20ac962fa67'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
