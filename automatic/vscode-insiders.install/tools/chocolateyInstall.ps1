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
  url            = 'https://az764295.vo.msecnd.net/insider/2946b1ee55db1d406526d3fd1df49250b2f8322d/VSCodeSetup-ia32-1.79.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/2946b1ee55db1d406526d3fd1df49250b2f8322d/VSCodeSetup-x64-1.79.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'ce7a519537a6d9730338370a5e9acd3afa3026dbf6697d3f10f31368a8ac8259c1bd496c3e2222d4fa778dfce1d8499122f0bced1d3a55e02e5a066f45a7e949'
  checksumType   = 'sha512'
  checksum64     = 'eb51b10ce9c710fc84fc694dbf2760cbc31a2b56434cffaef6b0d9972b37bfd5f26785806d33e3cf525f9f8e59f19ef9d771ef5e4bf8636b7804c871aedaa512'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
