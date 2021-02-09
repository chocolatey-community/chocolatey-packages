$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.53.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/5d424b828ada08e1eb9f95d6cb41120234ef57c7/VSCodeSetup-ia32-1.53.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/5d424b828ada08e1eb9f95d6cb41120234ef57c7/VSCodeSetup-x64-1.53.1.exe'

  softwareName   = "$softwareName"

  checksum       = '62398285c37a0ad1caa8f721ae8388c2d682edb8c33674fd430d10333b53d9fb'
  checksumType   = 'sha256'
  checksum64     = '9ac575795e1708c386969f6fee5de9b4ca931185d254bbbd316bd3e0837de66e'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
