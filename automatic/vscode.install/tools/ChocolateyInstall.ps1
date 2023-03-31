$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.77.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/7f329fe6c66b0f86ae1574c2911b681ad5a45d63/VSCodeSetup-ia32-1.77.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/7f329fe6c66b0f86ae1574c2911b681ad5a45d63/VSCodeSetup-x64-1.77.0.exe'

  softwareName   = "$softwareName"

  checksum       = '0fa7c9aedc1ef103885778efb3ef5ec76cedc862d91655f27fbc6b7d39a14b90'
  checksumType   = 'sha256'
  checksum64     = 'b2d0bc1edf79eb9ce80dde96f7b3ead76a3bda28ff0d3e4ff887b3ee5271a8ad'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
