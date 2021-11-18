$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.62.3'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/ccbaa2d27e38e5afa3e5c21c1c7bef4657064247/VSCodeSetup-ia32-1.62.3.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/ccbaa2d27e38e5afa3e5c21c1c7bef4657064247/VSCodeSetup-x64-1.62.3.exe'

  softwareName   = "$softwareName"

  checksum       = 'cb73afa0fd7c1e7fd364217e271d0df3647b6b06e91767a885d053be74ca470c'
  checksumType   = 'sha256'
  checksum64     = '5326727158924133f0da9fd495f4f07b4b184d04dd5e4c9b4a3a84e9a647f95c'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
