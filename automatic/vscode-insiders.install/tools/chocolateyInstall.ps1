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
  url            = 'https://az764295.vo.msecnd.net/insider/6c8c6008ef9d86e46b086a00f273b1fee5bd8c51/VSCodeSetup-ia32-1.51.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/6c8c6008ef9d86e46b086a00f273b1fee5bd8c51/VSCodeSetup-x64-1.51.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '1182d6eb74037948a51667f9b86c3e20a9376ddf4ef4dde336400a7ee3b3bbc5f7fcbddc7950b942e6e712ec7f2b373debdca874a7fd94694127b16e75763d33'
  checksumType   = 'sha512'
  checksum64     = '5f16206f8d2d05528b43ff272906c1a62bee71cc9dd04337495b1cf954089890e545689e793137221889730acc6a3f6874be680367ea05ebbe640c6ea71287be'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
