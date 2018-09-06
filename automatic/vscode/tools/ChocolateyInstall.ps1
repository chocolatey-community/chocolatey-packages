$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.27.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/5944e81f3c46a3938a82c701f96d7a59b074cfdc/VSCodeSetup-ia32-1.27.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/5944e81f3c46a3938a82c701f96d7a59b074cfdc/VSCodeSetup-x64-1.27.1.exe'

  softwareName   = "$softwareName"

  checksum       = 'a304596a64eb00d3eb5d3910c4a2d6f356408e713b1ee232f5eb558f9146ba83'
  checksumType   = 'sha256'
  checksum64     = 'd4387b1c944d1f05b3e27071997b70ad601633c5a5884d2fc88486fff1b26462'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
