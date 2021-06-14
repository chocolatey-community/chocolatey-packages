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
  url            = 'https://az764295.vo.msecnd.net/insider/e1161be26874f0d39a5b9cdeb2c5fbfd4f83bb80/VSCodeSetup-ia32-1.58.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/e1161be26874f0d39a5b9cdeb2c5fbfd4f83bb80/VSCodeSetup-x64-1.58.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '74893788194fac9bdcd2d41ac3a1aed88aecdd1af1e47bf5873397f3547dc572ae885c3376bd457c14a74784d7b37b01392fcfd23c025a49ca1bcdbacf7567c9'
  checksumType   = 'sha512'
  checksum64     = 'da1054c5eb7b1bf328f32dd0735bf395f317c220ba3633128a4c3f7a0460400d20bb62ee7693fd9dc24dad9889b8112e2d66bd226acc0de52f8d05c4a1d4b643'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
