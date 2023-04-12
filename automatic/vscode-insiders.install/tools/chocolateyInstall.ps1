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
  url            = 'https://az764295.vo.msecnd.net/insider/e5512217bcfb2b644fe7ad6c465fe0b45d23265b/VSCodeSetup-ia32-1.78.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/e5512217bcfb2b644fe7ad6c465fe0b45d23265b/VSCodeSetup-x64-1.78.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '0467d658412603a1ce140c6fc31b4faa80a0ec5282f8eb9acf6c2ccbeb891c7b78a9b26bce9e7eac0fb57599f331fafaf26c2b233113169544688e79c8c72d16'
  checksumType   = 'sha512'
  checksum64     = '80b51e53132f6f54edcfb0980096828386c0e9475a3f5f7365d99436c8fc595793cdd97db90891bf8c58bd8f5e10a80605cd5af6ecdcb83022529be666b3f93d'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
