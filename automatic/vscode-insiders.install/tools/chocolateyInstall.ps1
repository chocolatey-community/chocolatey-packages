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
  url            = 'https://az764295.vo.msecnd.net/insider/6243562032a9a168df33c1b4dc84d5b2abbcb22d/VSCodeSetup-ia32-1.81.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/6243562032a9a168df33c1b4dc84d5b2abbcb22d/VSCodeSetup-x64-1.81.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '8fb5ba23e3711a1d8eb83a35dbda3aca48fed94f356656b094216deb086ce017d8193070304f1b1424cb30dbe02c2cd352a5ecb4d6dd337a65319a6acefea716'
  checksumType   = 'sha512'
  checksum64     = '9a399f61aa3310975aa21bc993db807e0eaffa3550939c3aaca162d8f7ccd17907043c234392fd86655a5c190f41c51dc1b5774a7a75980157d3d78e3eed81c1'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
