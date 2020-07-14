$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.47.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/485c41f9460bdb830c4da12c102daff275415b53/VSCodeSetup-ia32-1.47.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/485c41f9460bdb830c4da12c102daff275415b53/VSCodeSetup-x64-1.47.1.exe'

  softwareName   = "$softwareName"

  checksum       = '1e173ab33e74d1f0a34a5e7a7ab03c1468553f5c24e23a7f7ada09c52bb4b5e5'
  checksumType   = 'sha256'
  checksum64     = '1406d764388583bdd67a413c36886ac7f3ea2f0dc8d2d4455c8df2d514ec5f34'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
