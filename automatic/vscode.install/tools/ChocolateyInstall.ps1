$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.46.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/a5d1cc28bb5da32ec67e86cc50f84c67cc690321/VSCodeSetup-ia32-1.46.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/a5d1cc28bb5da32ec67e86cc50f84c67cc690321/VSCodeSetup-x64-1.46.0.exe'

  softwareName   = "$softwareName"

  checksum       = '923ca4015e52575c947f681303a0f2dc82750761a9f88d618f0883f81e86007d'
  checksumType   = 'sha256'
  checksum64     = '6d800b3b178eb96f8d060dbd68438915360366b755d095f336a91e4686fd60f1'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
