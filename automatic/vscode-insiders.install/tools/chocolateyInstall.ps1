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
  url            = 'https://az764295.vo.msecnd.net/insider/9084e081d4e89ed8ab67fce340d573c4e1378939/VSCodeSetup-ia32-1.79.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/9084e081d4e89ed8ab67fce340d573c4e1378939/VSCodeSetup-x64-1.79.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '413b361ad3eb9d7cd6abbaaf4d4316a813a1d9acf14cebd3b85b1473f40a25d4acdac8c99bd4e67c1f1ebc3fb98e8f0700f9c11ee75bbc67c5b5a7e771355194'
  checksumType   = 'sha512'
  checksum64     = '6bf0c864d6b38f12d6e1bcce4c7f3328251e8ee5c3164af89e27d035cd28882bfb4c35a7fd24be11fdd90ac8f837d3451d65789cf24cf42a536f3c4cde1d3f1f'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
