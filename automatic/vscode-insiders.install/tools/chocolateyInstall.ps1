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
  url            = 'https://az764295.vo.msecnd.net/insider/50089c3f92c17584a4aca179f51f220b56c22020/VSCodeSetup-ia32-1.65.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/50089c3f92c17584a4aca179f51f220b56c22020/VSCodeSetup-x64-1.65.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '67836f7c0256857b333d73cb2ac9cd2faaa919b15aeb48a64127f1c2f4564245502ea583b1237b16b22aef17becae03e1ac2e92efb8705b4360211d823af4456'
  checksumType   = 'sha512'
  checksum64     = 'ffd8eeb05da9ed2bf36f7c24972bc7272f518d3393697afc569d2dc6f1357be3b16baf78ad39a8e6e294a8d1e81a8a27cd28e5490ba52fec8f33f5c1549859c8'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
