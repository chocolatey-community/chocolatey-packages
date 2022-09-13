$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.71.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/e7f30e38c5a4efafeec8ad52861eb772a9ee4dfb/VSCodeSetup-ia32-1.71.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/e7f30e38c5a4efafeec8ad52861eb772a9ee4dfb/VSCodeSetup-x64-1.71.1.exe'

  softwareName   = "$softwareName"

  checksum       = '3894ed688692e0cd05ae87d9c1f014fcc80208db2b814c55e492eae8b29714c4'
  checksumType   = 'sha256'
  checksum64     = '4bd59cd974cdd5f06fb6474f57e3b036265a79b4f080d789a87d82d6a7bcb924'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
