$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.55.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/08a217c4d27a02a5bcde898fd7981bda5b49391b/VSCodeSetup-ia32-1.55.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/08a217c4d27a02a5bcde898fd7981bda5b49391b/VSCodeSetup-x64-1.55.1.exe'

  softwareName   = "$softwareName"

  checksum       = 'd7ccaf0393a5ccf5b110ad717132f4dce404cd6ebb7c709293aea424e9fa3564'
  checksumType   = 'sha256'
  checksum64     = '02369bfdfea9ee251fc8077e4921e96307d2088364afa7091fbc27b1a1dc65c6'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
