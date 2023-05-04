$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.78.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/252e5463d60e63238250799aef7375787f68b4ee/VSCodeSetup-ia32-1.78.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/252e5463d60e63238250799aef7375787f68b4ee/VSCodeSetup-x64-1.78.0.exe'

  softwareName   = "$softwareName"

  checksum       = '4fea6aa02e65c16491c6f460994e1bce12bf5469c3cdba0b33e32042ede7bf6b'
  checksumType   = 'sha256'
  checksum64     = '0994784b9c3612426e166727ba933cfcfc51cf1d65b910928840aacc8d7d8a2c'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
