$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.82.3'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://update.code.visualstudio.com/1.82.3/win32/stable'
  url64bit       = 'https://update.code.visualstudio.com/1.82.3/win32-x64/stable'

  softwareName   = "$softwareName"

  checksum       = '31b55f6e3cd23850a4931a0270e9efb89b9344b40e3320ef860d7d3e3f54c957'
  checksumType   = 'sha256'
  checksum64     = 'b704f7647e0efb2ce8d264e3c75846b11d07491ae6b1d9d140b8d02803b3d9fc'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
