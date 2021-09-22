$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.60.2'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/7f6ab5485bbc008386c4386d08766667e155244e/VSCodeSetup-ia32-1.60.2.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/7f6ab5485bbc008386c4386d08766667e155244e/VSCodeSetup-x64-1.60.2.exe'

  softwareName   = "$softwareName"

  checksum       = 'fdd34a931f094b9f0dce5abd834cb065082001fcb181d03e11c1fc2382066c87'
  checksumType   = 'sha256'
  checksum64     = '21ed75797a1232b4958a5dc4da52033adc7646045001a67cc901254e2c00e7fb'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
