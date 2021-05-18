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
  url            = 'https://az764295.vo.msecnd.net/insider/45aafeb326d0d3d56cbc9e2932f87e368dbf652d/VSCodeSetup-ia32-1.57.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/45aafeb326d0d3d56cbc9e2932f87e368dbf652d/VSCodeSetup-x64-1.57.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '45a8d17a594ab2a746520bae18c9f49fe9fca0e359db98dae248010db890f8323ded5d2fdb0e9395726a6d25a676b059b46ed934c62dd132f4889be0eeafe46f'
  checksumType   = 'sha512'
  checksum64     = 'a922a9601da96d94e511db900d601f69a1827f9d26e91b5da01d55939ca335242d5f8f6545a9ea708ad76e552fe315c832d7504c45db5ec76f09284d99fd2bdf'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
