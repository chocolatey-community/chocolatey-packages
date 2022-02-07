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
  url            = 'https://az764295.vo.msecnd.net/insider/97c1e76d668d23d568044feb31083407f4c4b1ed/VSCodeSetup-ia32-1.65.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/97c1e76d668d23d568044feb31083407f4c4b1ed/VSCodeSetup-x64-1.65.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'db16ba7faff45db46865805c43b005eaaab3c904f7580d5c61c9ed00f1ff4e18bb3da83b765ab9c9558f2ebfc4ef5fad6678161f8b2eb8bb7efdcb40555c3464'
  checksumType   = 'sha512'
  checksum64     = '2f13c8d76db53fbf2a1febf9fc58e4691eaaa75c123383acfeb262a604ab8e52f401c60fc8459da1dd0e89bb03bc3e5b72b0e8b6db06cce9463268287bd3190e'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
