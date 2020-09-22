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
  url            = 'https://az764295.vo.msecnd.net/insider/e80644fd7da69295b18e7f79403720dd1b155507/VSCodeSetup-ia32-1.50.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/e80644fd7da69295b18e7f79403720dd1b155507/VSCodeSetup-x64-1.50.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'db7737383d7f476f1d2c78fa40a3e27e0a78bf81f4a722bdbfa1a912cebf7df6136121099652ad9ca76eb15e98c794e757eb335d5dfa04ccbe52da984a10d9cb'
  checksumType   = 'sha512'
  checksum64     = 'ff7c24b80d23d67041617c947c36dc224d31ac33975c9f74aa41abf6868b3c4f560bf740a8a926f3c70d263682409f0a5964489ce2c30779436e1deeec40a70a'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
