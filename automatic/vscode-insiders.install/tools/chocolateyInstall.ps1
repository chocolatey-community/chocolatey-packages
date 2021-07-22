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
  url            = 'https://az764295.vo.msecnd.net/insider/e8a59bc6f920e731b47f0bc72263e82aba8b796e/VSCodeSetup-ia32-1.59.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/e8a59bc6f920e731b47f0bc72263e82aba8b796e/VSCodeSetup-x64-1.59.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'b6ba7d8ee434d2284b3b9cdffba87bb1ed30915f58392d1138b7384e9e3ac514ba6583cbbd438a43b6568e2be9b1e2cca0a1e2e2ed41d34238e36afa225d581a'
  checksumType   = 'sha512'
  checksum64     = 'bb5cfc69f88ab2caa2aa055939c48241d8cc476f6e6c9e66555f8f44bcd1d15d923571824d0833f87c5df34ec654e27721b93c9b50bb9c73bbef7a3447fc82d0'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
