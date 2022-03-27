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
  url            = 'https://az764295.vo.msecnd.net/insider/10dc49b279e2f8ab0194a0e831ade4ea773b8a55/VSCodeSetup-ia32-1.66.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/10dc49b279e2f8ab0194a0e831ade4ea773b8a55/VSCodeSetup-x64-1.66.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'ce24cc9e846ac9d3256552f3a5850ad5f2fc7c654d066910d6b847b6172492d5f91d2b150f9742e1dc7e8199c0ee4349af77226726ba79bea04f641f85aae964'
  checksumType   = 'sha512'
  checksum64     = 'b124daf9ba7046c187d41390df13de3a27307bbdef44f7ef87036afc484c811a6ede890f01e44d4f7357c21b9be252f2286705b8f53e27f5dbab78842e222eb7'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
