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
  url            = 'https://az764295.vo.msecnd.net/insider/835d39cfac9ede6c7c90678c8d6c3d4d0171ed6d/VSCodeSetup-ia32-1.72.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/835d39cfac9ede6c7c90678c8d6c3d4d0171ed6d/VSCodeSetup-x64-1.72.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'b2ad6d8d2bf914c4b97caff2cc78708b597fbfc3be17977da8865c7df8a0542427ac78c834eaee28a75ae30eb25771330b9e5281cddf6d07dcc4a4ba86588f66'
  checksumType   = 'sha512'
  checksum64     = '6c7eac7a9749dec1b99b792df3fe26467b40e83806b730729ce7ac5ca899a25e9f21ee92f4823d7a6e11eb95be55fe439811d7617a0851757027e7cda00a80c0'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
