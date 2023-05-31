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
  url            = 'https://az764295.vo.msecnd.net/insider/fa8eefda18bf099d82b58453f8fe5d3010196fa0/VSCodeSetup-ia32-1.79.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/fa8eefda18bf099d82b58453f8fe5d3010196fa0/VSCodeSetup-x64-1.79.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'b67adb937a88f8a6cd8de5fb3619d9de86defe6d51baf7ceb1b4d6962906a15d5da5cdea2a4988036afa66e7bb91a00723f60914c7daeee33bd2c33249a2a1b1'
  checksumType   = 'sha512'
  checksum64     = 'cbbb9179fe74235b555fc798cae08068809e01fa63a70b1cc14e6afaa5bca005317f9fbd47d90aaf110456606d5ca8086e3200169cf4cef3377c6a8007caeac9'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
