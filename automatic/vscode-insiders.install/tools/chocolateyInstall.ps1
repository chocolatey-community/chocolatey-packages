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
  url            = 'https://az764295.vo.msecnd.net/insider/a74adedba8fb56d14f01f7950340dab33cfeae57/VSCodeSetup-ia32-1.70.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/a74adedba8fb56d14f01f7950340dab33cfeae57/VSCodeSetup-x64-1.70.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '5f91709a92ac2e6583f4efd931126bcf92da90695d4149fbc6abf721122049312736ece1747ad300251a314a30e175b6d3ab513d8fd3a6a2b4ae0c67a2d2c0c8'
  checksumType   = 'sha512'
  checksum64     = 'adc54185ad4fbced3ffedd05a9ddfcde2271a544264f81e62d04046460817530095620334b45fde507ece63c08800ac8da816f15f328b4847bfc68d6c2cd2b0b'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
