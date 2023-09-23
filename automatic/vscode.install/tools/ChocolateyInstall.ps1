$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.82.2'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://update.code.visualstudio.com/1.82.2/win32/stable'
  url64bit       = 'https://update.code.visualstudio.com/1.82.2/win32-x64/stable'

  softwareName   = "$softwareName"

  checksum       = '76cf4fbe3d371402d94e79840d16e65c7e0ada7e5c12ac002a7fc8b285d2770c'
  checksumType   = 'sha256'
  checksum64     = '9dcd084c2e666af8b6bfbc0f3f45610250d6cae14d7a1570e611fb8c88867df7'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
