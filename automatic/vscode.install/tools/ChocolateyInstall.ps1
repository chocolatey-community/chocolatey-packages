$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.60.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/e7d7e9a9348e6a8cc8c03f877d39cb72e5dfb1ff/VSCodeSetup-ia32-1.60.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/e7d7e9a9348e6a8cc8c03f877d39cb72e5dfb1ff/VSCodeSetup-x64-1.60.0.exe'

  softwareName   = "$softwareName"

  checksum       = 'e103b76f8a062110b9619b75af6ee3c935c070b5f22ae4b1bf8fde2ed59ecd60'
  checksumType   = 'sha256'
  checksum64     = '2dc9d7eddb2a968431acf5ce5c85b09967b3c87e22f46534e1aa52daa8f07526'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
