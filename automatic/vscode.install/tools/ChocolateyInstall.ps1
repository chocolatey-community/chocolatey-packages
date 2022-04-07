$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.66.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/8dfae7a5cd50421d10cd99cb873990460525a898/VSCodeSetup-ia32-1.66.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/8dfae7a5cd50421d10cd99cb873990460525a898/VSCodeSetup-x64-1.66.1.exe'

  softwareName   = "$softwareName"

  checksum       = '117f69867ae58b500c7ff0ffe62ce3a9500025ebb637b164dd89ea5145e544e5'
  checksumType   = 'sha256'
  checksum64     = '5e7c31755960adbfc1798fcdd6173acd06b90eeb57e40c911ad4d23638b42744'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
