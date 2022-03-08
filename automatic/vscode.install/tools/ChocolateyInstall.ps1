$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.65.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/8908a9ca0f221f36507231afb39d2d8d1e182702/VSCodeSetup-ia32-1.65.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/8908a9ca0f221f36507231afb39d2d8d1e182702/VSCodeSetup-x64-1.65.1.exe'

  softwareName   = "$softwareName"

  checksum       = 'e068f05f7cc432a82ac97c8f01ec3518ce601b0a759e8bb057a3307a77b6e981'
  checksumType   = 'sha256'
  checksum64     = '71028f6e42d4ea1cd27f5338b0e396431f4020b9fc13a280ec5321510faa0947'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
