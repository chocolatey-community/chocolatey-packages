$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.28.2'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/7f3ce96ff4729c91352ae6def877e59c561f4850/VSCodeSetup-ia32-1.28.2.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/7f3ce96ff4729c91352ae6def877e59c561f4850/VSCodeSetup-x64-1.28.2.exe'

  softwareName   = "$softwareName"

  checksum       = '9265e84cdb0c1f5bc9f605b0f0467acfca349d874596ca3788aeaee0440e5861'
  checksumType   = 'sha256'
  checksum64     = 'ccb4db2f5c78555cc08588bcd8090878d2c6ab9bb3f4a7f79cd8db9d1074f04d'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
