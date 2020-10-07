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
  url            = 'https://az764295.vo.msecnd.net/insider/93c2f0fbf16c5a4b10e4d5f89737d9c2c25488a3/VSCodeSetup-ia32-1.50.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/93c2f0fbf16c5a4b10e4d5f89737d9c2c25488a3/VSCodeSetup-x64-1.50.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '3413b103a23e50828319b9461e0209740f20f5208ec839928421bfadb405a3198ddda4c0675dc99c2fe1499460b1da0cbafcb13d4857dc2a769e17a281ed6ac5'
  checksumType   = 'sha512'
  checksum64     = 'df9032c1dd77087c4edfa6aa153bf4d2e0c19f0543a76dd21e4de24d8f3bc3462c1d4ac77add0b5924d31ab7252bc9a28e191df7453af8cb3bdf8cee335eb149'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
