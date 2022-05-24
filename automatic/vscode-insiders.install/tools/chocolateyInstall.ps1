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
  url            = 'https://az764295.vo.msecnd.net/insider/27ea5e48aef2a62b76ab170026ade228ded8abdf/VSCodeSetup-ia32-1.68.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/27ea5e48aef2a62b76ab170026ade228ded8abdf/VSCodeSetup-x64-1.68.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '2f6197162b0f83813a9cca9099ff561148be044c083d0ed8f1effd63609741accd9e6e857db3961785a44ece0eeb5503fefaab657c2e5beb429a73aaca2b79f7'
  checksumType   = 'sha512'
  checksum64     = '79d6c09fe64ef759605929a771021876e94bdc513d748f957377a1cc77561d80dfb038e99ccfd762ccffaac9f8c9f4afbb6ec073b558b681fe1434019be88450'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
