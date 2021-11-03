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
  url            = 'https://az764295.vo.msecnd.net/insider/b3318bc0524af3d74034b8bb8a64df0ccf35549a/VSCodeSetup-ia32-1.62.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/b3318bc0524af3d74034b8bb8a64df0ccf35549a/VSCodeSetup-x64-1.62.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '2ad74c4814ad68d49a6736e2713063ef89e43578deef646353e8a10a277bbccf98f33487f1ae2621beab07ac857e9f80cf335e9aacfe85c0443a77f591ac7861'
  checksumType   = 'sha512'
  checksum64     = 'b3a424f9702587db673d2bc7ed108f43dd210270f37df9c1816897efcf0a68a0a74c66dc2cade2b95a53fa23010878eb2b9fb197c98a25876335845e26a73138'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
