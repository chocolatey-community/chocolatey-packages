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
  url            = 'https://vscode.blob.core.windows.net/insider/1379f0375440df946adc62f7afb8375dd45d5adf/VSCodeSetup-ia32-1.75.0-insider.exe'
  url64bit       = 'https://vscode.blob.core.windows.net/insider/1379f0375440df946adc62f7afb8375dd45d5adf/VSCodeSetup-x64-1.75.0-insider.exe'

  softwareName   = 'Microsoft Visual Studio Code Insiders'

  checksum       = '9ba5598d68a8facf1bd0b53b7d61953b9be42773fd4b4fca80ab8fbbfa808c8d6db0a92210e5e939ce74d88f0d3c020d6a1dbe8cd69a3e50f8f9f314a928e3f6'
  checksumType   = 'sha512'
  checksum64     = 'f5608d117d7f5802fc3131459803086a07ec9b8d2c6a4c271420c626f09db1666e8f13c9f7f2cb2a5f22bb5c9715bdf8912970ecc2fa4e733162d1a6f237e3ae'
  checksumType64 = 'sha512'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
