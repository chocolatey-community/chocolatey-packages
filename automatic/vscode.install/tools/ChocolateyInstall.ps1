$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.82.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://update.code.visualstudio.com/1.82.0/win32/stable'
  url64bit       = 'https://update.code.visualstudio.com/1.82.0/win32-x64/stable'

  softwareName   = "$softwareName"

  checksum       = '8c728224876462584ce7aad0dfff336addd220093db3532037e60a0337934d9e'
  checksumType   = 'sha256'
  checksum64     = 'e3bb3fb48b2c3cddd0c482f427af46e8e92b50c4b7fe96b28ac649ae3f836dd4'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
