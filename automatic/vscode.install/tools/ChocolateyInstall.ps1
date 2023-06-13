$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.79.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/4cb974a7aed77a74c7813bdccd99ee0d04901215/VSCodeSetup-ia32-1.79.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/4cb974a7aed77a74c7813bdccd99ee0d04901215/VSCodeSetup-x64-1.79.1.exe'

  softwareName   = "$softwareName"

  checksum       = 'f5ea7e83c331702c4befabc6e683c400393e3a2b42740012e4293b475ef7459e'
  checksumType   = 'sha256'
  checksum64     = 'bd3efa6bb9d76166142443b76c54ed934cdb6d5a8b1a6e839fa5068eed609150'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
