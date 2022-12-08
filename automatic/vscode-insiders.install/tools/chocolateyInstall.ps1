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
  url            = 'https://az764295.vo.msecnd.net/insider/b92894493e6f971a3c71912d823e699d3a05d643/VSCodeSetup-ia32-1.75.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/b92894493e6f971a3c71912d823e699d3a05d643/VSCodeSetup-x64-1.75.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '5abca99ba9f0c9b25a840fa1d2754fb3f54d3238409e86a8dfd8137838191d9cd65ed46a2909087f2584b90221980014c28af6cd52f6a89cf827e6b3baab73ad'
  checksumType   = 'sha512'
  checksum64     = '01dba21bd75bb6066928c9fc8658d0f69b1738f22c27f0f1321c1365c0b7ba8db2d2baf69b8fc2c2307589705335addfe5f0f2cbd618e9b1012bd1453ebcb2d7'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
