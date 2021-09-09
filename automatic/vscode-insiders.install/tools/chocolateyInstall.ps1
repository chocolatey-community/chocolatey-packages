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
  url            = 'https://az764295.vo.msecnd.net/insider/aa93eefe550167de3ca29aaa3d06f721a47594a3/VSCodeSetup-ia32-1.61.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/aa93eefe550167de3ca29aaa3d06f721a47594a3/VSCodeSetup-x64-1.61.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '00e7c7ea0c3467182ee57bc03a36a03b2b3bb01194d603901051a902b55b4c6c854499d1874a25d387106a4a87021e41ce3abb74718cb3e216960f4f5a5b1815'
  checksumType   = 'sha512'
  checksum64     = '86b39b9e1ba4492e2bb130874f8b8f2e8b8e89e9dd531d71a1a1f33c638029cc1877e88e3f38ad44d2ee7ba62e0bf7595d15ca16aae6a715726760df5694fa0f'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
