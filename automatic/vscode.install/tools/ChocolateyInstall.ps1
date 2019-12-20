$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.41.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/26076a4de974ead31f97692a0d32f90d735645c0/VSCodeSetup-ia32-1.41.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/26076a4de974ead31f97692a0d32f90d735645c0/VSCodeSetup-x64-1.41.1.exe'

  softwareName   = "$softwareName"

  checksum       = 'd72dfa1e4644e0bbe7ebe7243a2ac59f51b2d2ca261bb24936f2879ad1d6aac3'
  checksumType   = 'sha256'
  checksum64     = 'cfde2bc9e601d3d1ab4a1f43c4a5d8c352b41a82cc97732a0c07ccaed3d2c086'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
