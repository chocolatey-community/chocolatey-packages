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
  url            = 'https://az764295.vo.msecnd.net/insider/7c25c174726ab969db3f99058cdf24bcfae1cfbe/VSCodeSetup-ia32-1.60.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/7c25c174726ab969db3f99058cdf24bcfae1cfbe/VSCodeSetup-x64-1.60.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'f1ba1ac14704247931436b7b422b224700d83e41754b5e1e85fd879b5936b16132be678075d35cf5c2497393dec64b6a65b7b9296843e94b0a5243a6a5aaf45c'
  checksumType   = 'sha512'
  checksum64     = 'c6ba9ffea7829c47c9bf939478a97fcf220a96de61b44b9b9ac039834ec8744a742da867419c1091787b6f76a4fc5fec72823134315575fc22ecbf977914d5d8'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
