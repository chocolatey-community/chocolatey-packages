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
  url            = 'https://az764295.vo.msecnd.net/insider/89bbd372f459ce72e9c0b60eb3b26b924f64f62d/VSCodeSetup-ia32-1.60.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/89bbd372f459ce72e9c0b60eb3b26b924f64f62d/VSCodeSetup-x64-1.60.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '18661def6014b7ddc7c3bb6d3d3456ece29a4fd015a292e4eff158587a4aaca4e42708fe503691c4c626c871c11f3750ed5289040863a6cfa875374612b9b05c'
  checksumType   = 'sha512'
  checksum64     = '6de0c1ec4649dfc81cfb3ffb508c45bf34206555e64c9d7efc3b7163f4aca6efbd22868ebcb93420dfae422f08de66aef28aa68020b55d7e47e53c97ab4221af'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
