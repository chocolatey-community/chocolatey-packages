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
  url            = 'https://az764295.vo.msecnd.net/insider/0214d59846f265d9e50f53b61e2267407d81cbfb/VSCodeSetup-ia32-1.60.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/0214d59846f265d9e50f53b61e2267407d81cbfb/VSCodeSetup-x64-1.60.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '7c58db626be3190bfa94b2dcfe0554bb6458b1c5e3d01372a04a8230809b94edbb16c8e44d3c42f713951505a680c43f6e73757f80caf14b70fb37dfb2ab142a'
  checksumType   = 'sha512'
  checksum64     = '2dbbc81c4057cc1025c9ce448fa4b71728a9e47e2b29ccabf2bde8c275e9b136d79a10d2596f6f0a54146d347b098cf1e2a6f45afc955ad72d6e7abccbdd8ae3'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
