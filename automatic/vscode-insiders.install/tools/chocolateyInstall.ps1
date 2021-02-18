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
  url            = 'https://az764295.vo.msecnd.net/insider/6eaef7d42f982a0e9b22ac465245fc2c27721fd0/VSCodeSetup-ia32-1.54.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/6eaef7d42f982a0e9b22ac465245fc2c27721fd0/VSCodeSetup-x64-1.54.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '014102e89e1582993ee42a00c22d4bb622683f50e033b24416aa108240d1a61d1d0849a9faa99e34de5ca43c32f819944039ff7a1f690c8f8e2eda1bde37669d'
  checksumType   = 'sha512'
  checksum64     = '2d1b4e45c49d3ec81a43504f1cc9691441ee4b0cbf379de6782669d63cde4c629b8bdb2c9cd19025e9d318ef8d93a4ca4192e57bf91ad5fedaf87736e93f372c'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
