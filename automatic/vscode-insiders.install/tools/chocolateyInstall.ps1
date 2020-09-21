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
  url            = 'https://az764295.vo.msecnd.net/insider/ed3df6e1ea22603fe348c83b1ce4b4179c2d8fb3/VSCodeSetup-ia32-1.50.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/ed3df6e1ea22603fe348c83b1ce4b4179c2d8fb3/VSCodeSetup-x64-1.50.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '698829210254aa1ad3b3952217f141a7d381266298d8746c1062f7012f36f15d102ca1084c3ebbdc7e477d7918887c05dff22852a35b67e207285919f16327e5'
  checksumType   = 'sha512'
  checksum64     = '29d6e43b927aa50d7f88c867bdbd18a7f8b8d264a148f468dbd8c248e3fe8461adbd6ad959931a6efe092e03a85e488f4cc4a715680402ce48376ed37321664a'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
