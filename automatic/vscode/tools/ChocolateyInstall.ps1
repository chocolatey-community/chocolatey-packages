$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.39.2'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/6ab598523be7a800d7f3eb4d92d7ab9a66069390/VSCodeSetup-ia32-1.39.2.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/6ab598523be7a800d7f3eb4d92d7ab9a66069390/VSCodeSetup-x64-1.39.2.exe'

  softwareName   = "$softwareName"

  checksum       = '938a64309d4fda55d27ca1d14ad4ee9864981df960a57ff33ce74f21ebb38703'
  checksumType   = 'sha256'
  checksum64     = '115780c7946464a846d74cc39fd671e9c866a0d348133e5745af9c797b761259'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
