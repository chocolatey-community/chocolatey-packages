$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.71.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/784b0177c56c607789f9638da7b6bf3230d47a8c/VSCodeSetup-ia32-1.71.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/784b0177c56c607789f9638da7b6bf3230d47a8c/VSCodeSetup-x64-1.71.0.exe'

  softwareName   = "$softwareName"

  checksum       = '5a0a0b053bf099507bb50c2c9fa7a8133c0286969cf94811853a3e8d01de00ad'
  checksumType   = 'sha256'
  checksum64     = 'fa573edf879ba238ee8d1c007f6eeef2e2f7270c67a839699624082c88e33d7f'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
