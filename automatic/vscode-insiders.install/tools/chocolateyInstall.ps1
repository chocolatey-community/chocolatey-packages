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
  url            = 'https://az764295.vo.msecnd.net/insider/1a582f7c079d1eb4c89d4f637da2fc2fcb688b31/VSCodeSetup-ia32-1.71.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/1a582f7c079d1eb4c89d4f637da2fc2fcb688b31/VSCodeSetup-x64-1.71.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'd00e79b457f9da44bd22b9fae278c3df109ff90fea65358fb56b9dea1f7ada5b453ff8afa883617721b8b1ab858a9df0402abf72db662359bd594a9073f19480'
  checksumType   = 'sha512'
  checksum64     = 'c7609f174e858e60a33fd5c05dc94547351d1fde83ea5c86ebf64b4df0bdc57f7359aac6a3167b5b92859208d5ea8d3944465de95fefb4294e18bcada35b02fa'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
