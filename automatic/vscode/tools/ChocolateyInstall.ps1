$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.33.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/0dd516dd412d42323fc3464531b1c715d51c4c1a/VSCodeSetup-ia32-1.33.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/0dd516dd412d42323fc3464531b1c715d51c4c1a/VSCodeSetup-x64-1.33.0.exe'

  softwareName   = "$softwareName"

  checksum       = '83fbdd08fa9329220c57541946efa56f8921a38b4c9af9005feb6ff8521e5ef3'
  checksumType   = 'sha256'
  checksum64     = 'fdb983538c35344952dad153cf049168cd73ad498bfe7ece92a00b29312abbd0'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
