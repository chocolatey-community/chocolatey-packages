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
  url            = 'https://az764295.vo.msecnd.net/insider/48cd8e0c1b142a46f0956b593d8331145634658e/VSCodeSetup-ia32-1.81.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/48cd8e0c1b142a46f0956b593d8331145634658e/VSCodeSetup-x64-1.81.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '5f00bcbf548cab114b61fd343f49c2bcb1fe9e257f5e46c99ee8c1b794c0b1cda437efcac360a46fdf3a9bb5e51ca16628de7930fb576819a711d2999634afda'
  checksumType   = 'sha512'
  checksum64     = '9d106dc3605d65b86c6d1278430a4e4b1cd920e52c27c2c894136f929e934b0eee49139b7c3a12143465bf9bfbf6a1d44e07bb30a4ea66d6387800f85b983b85'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
