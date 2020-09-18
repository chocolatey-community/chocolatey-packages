$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.49.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/58bb7b2331731bf72587010e943852e13e6fd3cf/VSCodeSetup-ia32-1.49.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/58bb7b2331731bf72587010e943852e13e6fd3cf/VSCodeSetup-x64-1.49.1.exe'

  softwareName   = "$softwareName"

  checksum       = 'f62af086962328813e375c15f5c584df3a810fbac027f57c2a6680f08251fd10'
  checksumType   = 'sha256'
  checksum64     = '884241b8a4cbfc0684cd144f0794d06beb4ef415f095c87740eef307f853e354'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
