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
  url            = 'https://az764295.vo.msecnd.net/insider/cead2f699cd0afb2464d8d3ad975776051583b4f/VSCodeSetup-ia32-1.59.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/cead2f699cd0afb2464d8d3ad975776051583b4f/VSCodeSetup-x64-1.59.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'c66dd5cacc82362f5f83fb47fb1b65c45f1329f3823c01e0192687372b3158925b542779504aa9c6c5cede57495c5a2be232584ed23b23595d0bf141926ef6b0'
  checksumType   = 'sha512'
  checksum64     = 'fa6915126195e32682dfe66eb6db430cd8036b2782868c3bc9532f1ad3b66ac10ee01f9c4e028dd7f5fe413d79fd625935d1218908857b1796edf6ff12065e97'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
