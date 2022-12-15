$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.74.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/1ad8d514439d5077d2b0b7ee64d2ce82a9308e5a/VSCodeSetup-ia32-1.74.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/1ad8d514439d5077d2b0b7ee64d2ce82a9308e5a/VSCodeSetup-x64-1.74.1.exe'

  softwareName   = "$softwareName"

  checksum       = 'b1be7b5c5317b3ddf5807b4ffd53b14d113f053c98c09e154d8a0a0eebec4634'
  checksumType   = 'sha256'
  checksum64     = 'e824f068797de93cc0f28ec0a881142aafc0d0f05f2157f617f2afa7959f1bd4'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
