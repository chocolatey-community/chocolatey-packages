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
  url            = 'https://az764295.vo.msecnd.net/insider/b5205cc8eb4fbaa726835538cd82372cc0222d43/VSCodeSetup-ia32-1.65.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/b5205cc8eb4fbaa726835538cd82372cc0222d43/VSCodeSetup-x64-1.65.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '2c70f7047d7f0f28709a1548b442edc84b5d8bf8861d390d4c55797936a6e3fb58bd062b8e7275d2a55c1c64bd11edbed3f3a4500b673494f54923833a8b7b62'
  checksumType   = 'sha512'
  checksum64     = '88d7bfd00de7fa4d27586f9adccb9edcea1a754425949f0014bdcf5fc2099c88386bf17b51a256fbd4e2adfbc4005e88c8147370e9da5ea2bc4cfd42c74be1b5'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
