$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.62.2'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/3a6960b964327f0e3882ce18fcebd07ed191b316/VSCodeSetup-ia32-1.62.2.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/3a6960b964327f0e3882ce18fcebd07ed191b316/VSCodeSetup-x64-1.62.2.exe'

  softwareName   = "$softwareName"

  checksum       = '8522b7fc40c3cf2085a32078658e7f4e783c74859cb641a16f6a687e5031c744'
  checksumType   = 'sha256'
  checksum64     = '3e67ecc86439bc85b5c64e5340b0091712b32034b946c77d206e8d487fac5104'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
