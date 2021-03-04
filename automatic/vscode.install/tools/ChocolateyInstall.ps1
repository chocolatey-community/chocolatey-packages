$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.54.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/42e27fe5cdc58539dad9867970326a297eb8cacf/VSCodeSetup-ia32-1.54.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/42e27fe5cdc58539dad9867970326a297eb8cacf/VSCodeSetup-x64-1.54.0.exe'

  softwareName   = "$softwareName"

  checksum       = 'decb37f81ee555538e735f73a602ff789f2d4311dbaaec3105ad14655ef2f72d'
  checksumType   = 'sha256'
  checksum64     = '02fdbd961762662f5bc3ad684b99f212960478cb03f9103363b6fa5ac467204f'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
