$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.62.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/f4af3cbf5a99787542e2a30fe1fd37cd644cc31f/VSCodeSetup-ia32-1.62.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/f4af3cbf5a99787542e2a30fe1fd37cd644cc31f/VSCodeSetup-x64-1.62.1.exe'

  softwareName   = "$softwareName"

  checksum       = '70351f704fe1fd37986101410a7b60bf4f62cc91adc582433a5862ec37d3f9e6'
  checksumType   = 'sha256'
  checksum64     = '4ed0b10b25125fdbcc0ed1e4de0027b4063729bd11e8f97f7f9856318cb33a33'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
