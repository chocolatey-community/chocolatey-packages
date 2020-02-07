$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.42.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/ae08d5460b5a45169385ff3fd44208f431992451/VSCodeSetup-ia32-1.42.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/ae08d5460b5a45169385ff3fd44208f431992451/VSCodeSetup-x64-1.42.0.exe'

  softwareName   = "$softwareName"

  checksum       = '59505e402f9b0598a6ed8ae30e0e67c2c9ef28cec850f35acc8c5d76eb0707a1'
  checksumType   = 'sha256'
  checksum64     = '84dd3851d480797a0635572f2d190b68718a01cd436b75bfc0a4c87fec7fba26'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
