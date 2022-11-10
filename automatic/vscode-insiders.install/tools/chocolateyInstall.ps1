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
  url            = 'https://az764295.vo.msecnd.net/insider/9d5741f01a67beea273121615b2d015fc298d9ea/VSCodeSetup-ia32-1.74.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/9d5741f01a67beea273121615b2d015fc298d9ea/VSCodeSetup-x64-1.74.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'ddd261d9af81e752b0bffb69b35e44206560e9747ca0d91312f8c994dceb8b8cf2d072e17d059f43b5da340cd1b2679223372153d005fbf82a364de9b96f7e72'
  checksumType   = 'sha512'
  checksum64     = '8feeac22860aa7258b279cb2530a013515ab202df3231c3b3e1af5f7f595748a61a3f7e7eddb9b982575b69cca13da5b63d0d8b11e99d189e4a44d71441ee943'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
