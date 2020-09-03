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
  url            = 'https://az764295.vo.msecnd.net/insider/8c9b4015feb0297d99c8051c35e85d208ffe83e3/VSCodeSetup-ia32-1.49.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/8c9b4015feb0297d99c8051c35e85d208ffe83e3/VSCodeSetup-x64-1.49.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = 'a57ccb1509741a1d408b2567431625b606b29ac328b1657ba6e85f9c5f32f1f15b3780fdb95de1899c0aa5267245b6f781d83a4ebc73c03789b7a578581963e3'
  checksumType   = 'sha512'
  checksum64     = '3416e975467fa2f83f079f9eeb32ea7dbc66e6dbce706918c96645a864eb6b5d78e2254aaab80afaa90e048a92ccadc4a0679aac040b3b67c5ef335a1fe2aacc'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
