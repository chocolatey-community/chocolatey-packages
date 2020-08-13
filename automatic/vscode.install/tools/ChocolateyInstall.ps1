$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.48.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/db40434f562994116e5b21c24015a2e40b2504e6/VSCodeSetup-ia32-1.48.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/db40434f562994116e5b21c24015a2e40b2504e6/VSCodeSetup-x64-1.48.0.exe'

  softwareName   = "$softwareName"

  checksum       = '7ec4ab065c29ce725f8f0665b3780d2b97916138d8330155eafc2b3535f80c4f'
  checksumType   = 'sha256'
  checksum64     = 'd1186a359165cc3ccf0d963b367caa8a81efda1abb8bb9641df3555d1729cacf'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
