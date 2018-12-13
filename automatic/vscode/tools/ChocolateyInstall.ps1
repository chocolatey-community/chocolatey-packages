$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.30.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/c6e592b2b5770e40a98cb9c2715a8ef89aec3d74/VSCodeSetup-ia32-1.30.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/c6e592b2b5770e40a98cb9c2715a8ef89aec3d74/VSCodeSetup-x64-1.30.0.exe'

  softwareName   = "$softwareName"

  checksum       = '9c0136d101b1fab1bd51110392cb20e666fb45d0015239421c84faa0a5ade4e4'
  checksumType   = 'sha256'
  checksum64     = '271d817d274912ad4ec578896c0de6f51f3a29d39b020defb3a503137d713304'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
