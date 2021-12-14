$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.63.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/fe719cd3e5825bf14e14182fddeb88ee8daf044f/VSCodeSetup-ia32-1.63.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/fe719cd3e5825bf14e14182fddeb88ee8daf044f/VSCodeSetup-x64-1.63.1.exe'

  softwareName   = "$softwareName"

  checksum       = '67c5ee5bece5cd269a9b6741cc4ee9a9e624ba37e4d35915658d4a969b8f3530'
  checksumType   = 'sha256'
  checksum64     = '5e7e1d42b08981f65b83e9a91d51c932335144f2f74c0c2719b069a71a78b257'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
