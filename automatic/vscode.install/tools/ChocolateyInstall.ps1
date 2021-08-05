$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.59.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/379476f0e13988d90fab105c5c19e7abc8b1dea8/VSCodeSetup-ia32-1.59.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/379476f0e13988d90fab105c5c19e7abc8b1dea8/VSCodeSetup-x64-1.59.0.exe'

  softwareName   = "$softwareName"

  checksum       = '882abf0f5c361c97bbcb253f3bf8d84930b608820664a2c8c5cd223b8b2cc482'
  checksumType   = 'sha256'
  checksum64     = '8688fb32eb44a9af54123ffceb2480a3c647d1e7f50eff22ed601be96ed24690'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
