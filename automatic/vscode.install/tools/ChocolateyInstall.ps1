$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.82.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://update.code.visualstudio.com/1.82.1/win32/stable'
  url64bit       = 'https://update.code.visualstudio.com/1.82.1/win32-x64/stable'

  softwareName   = "$softwareName"

  checksum       = 'ebbc683f14c1b51b0021307e6598f8cf89a6b11537ce7d9757aa3a3f41add0fa'
  checksumType   = 'sha256'
  checksum64     = '6de398ca7a840d90e1c7cfa29a8b49edabcbf88cdfa1731800be917880f0590d'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
