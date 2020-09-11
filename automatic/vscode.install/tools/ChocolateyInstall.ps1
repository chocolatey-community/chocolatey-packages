$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.49.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/e790b931385d72cf5669fcefc51cdf65990efa5d/VSCodeSetup-ia32-1.49.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/e790b931385d72cf5669fcefc51cdf65990efa5d/VSCodeSetup-x64-1.49.0.exe'

  softwareName   = "$softwareName"

  checksum       = 'f9066c3b09f38629684832efebe2d78aaeb054518be53df7c1daf8fc6f26f1c1'
  checksumType   = 'sha256'
  checksum64     = '1897e8bb33ab08b1b2c1ab812bfdf1621becbe51ef4e4c165f632c90ea0861f1'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
