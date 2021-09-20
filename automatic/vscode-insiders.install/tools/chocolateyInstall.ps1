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
  url            = 'https://az764295.vo.msecnd.net/insider/c28c86fcd12e4f8693d6569deadfc740dcf8f55b/VSCodeSetup-ia32-1.61.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/c28c86fcd12e4f8693d6569deadfc740dcf8f55b/VSCodeSetup-x64-1.61.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '23ebe7274fb7c356ff88abe18c8ddb157d9dc7d3bf84f178119c6934afaaba69452d8bb34cc9d42bc1b22795616af6b72a303783555c8cb8cb0e5a3ea395ad93'
  checksumType   = 'sha512'
  checksum64     = 'fdc6513023297ec617d972a2d98631df82e38f4153325f3cc7cc4a2e551775467655aaa0a7968977edb3ab04cf5380515b3d9c4a1e32883223486a1d6d45ae6b'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
