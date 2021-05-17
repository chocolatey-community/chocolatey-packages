$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.56.2'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/054a9295330880ed74ceaedda236253b4f39a335/VSCodeSetup-ia32-1.56.2.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/054a9295330880ed74ceaedda236253b4f39a335/VSCodeSetup-x64-1.56.2.exe'

  softwareName   = "$softwareName"

  checksum       = 'e953de91da3ffb129e5f88d7656a1be104cfd7dae4be2a7d00e4e81ff8d9af31'
  checksumType   = 'sha256'
  checksum64     = '1baa3ebad28b6e08c9806f8780690c6244f8aa89c47bc089e87a8f20b89f7492'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
