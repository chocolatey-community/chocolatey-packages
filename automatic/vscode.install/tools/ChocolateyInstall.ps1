$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.61.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/c13f1abb110fc756f9b3a6f16670df9cd9d4cf63/VSCodeSetup-ia32-1.61.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/c13f1abb110fc756f9b3a6f16670df9cd9d4cf63/VSCodeSetup-x64-1.61.1.exe'

  softwareName   = "$softwareName"

  checksum       = 'f1e88e0729fc15697629d40569d5ba789fd4cd97d466b1a3759fea4db6e6786e'
  checksumType   = 'sha256'
  checksum64     = '78cb00c352bd16304141cfea6b58825f845356f5574f01dfd2ea62cd0e480dae'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
