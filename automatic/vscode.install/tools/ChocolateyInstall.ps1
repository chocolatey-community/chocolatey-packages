$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.49.2'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/e5e9e69aed6e1984f7499b7af85b3d05f9a6883a/VSCodeSetup-ia32-1.49.2.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/e5e9e69aed6e1984f7499b7af85b3d05f9a6883a/VSCodeSetup-x64-1.49.2.exe'

  softwareName   = "$softwareName"

  checksum       = '11e9194b59ef4bb1edd964acabba12b67e7f2114c2652949a6ed2062236f70c7'
  checksumType   = 'sha256'
  checksum64     = '0d49771b69477caa989ed4644d20ba26d8bc55c4cee12d0a694268eb0742dea8'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
