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
  url            = 'https://az764295.vo.msecnd.net/insider/e7751367f79f327b8103bee33a07c16817a2c7cd/VSCodeSetup-ia32-1.69.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/e7751367f79f327b8103bee33a07c16817a2c7cd/VSCodeSetup-x64-1.69.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '7fdd7fe234f0306c795266ecd9ea4a02dd572f480bdde779d0e654de080ad9bb943563a7b426a3d0e6942fe343a9be4986d64e6725e4154400f6ff57f219f000'
  checksumType   = 'sha512'
  checksum64     = 'c8635144a65abbeb8d2cc1f5dc8a775fffbf99fb2200b18e30feb7ccb618190a64969642a575608e9d54b0ff2e18db8d2e0a64a019e60ca8d3b42336788c5556'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
