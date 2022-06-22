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
  url            = 'https://az764295.vo.msecnd.net/insider/f361c5b71d6676cfc6de97cdb1cc40b08bf7d994/VSCodeSetup-ia32-1.69.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/f361c5b71d6676cfc6de97cdb1cc40b08bf7d994/VSCodeSetup-x64-1.69.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'e4fc6f64962fab652208d0635acc3c9bcc706e11b6ba0511a6038c1a934104dfa70e1402672dd8e2c13ff2250fe02b5a3447e0f4856d8c53217aca92dc33462b'
  checksumType   = 'sha512'
  checksum64     = 'a087c581026f8969fcfd1ee2b94bff3345133a2e5edce1ef733cab5934bd83e09f1bea99a0ea72c2ad3751718be84ec51bf680450133cd250ccc973a8d3b5596'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
