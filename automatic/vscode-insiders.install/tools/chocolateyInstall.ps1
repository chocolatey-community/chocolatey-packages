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
  url            = 'https://az764295.vo.msecnd.net/insider/9056b400b527c562871093916081c3e6df2691dd/VSCodeSetup-ia32-1.58.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/9056b400b527c562871093916081c3e6df2691dd/VSCodeSetup-x64-1.58.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '6d51a7b0afdff9363c3c5e8665c66ab7a5b8e52db52c1f09f02f3bf39b266700fe26be23d021eece07e20893abaffa49a2630e1f01310d9a3c58eb5a664f54bf'
  checksumType   = 'sha512'
  checksum64     = '31a25b55f3c49cc922a65e09da844a7170376b5dc7b213a36dd74a5f020a6468dd5c934fde0ba5b68e5a1a61c66524863d5b3c7bfb3bd6af77ad2e4c00abb741'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
