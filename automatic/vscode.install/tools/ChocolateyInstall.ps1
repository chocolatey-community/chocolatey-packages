$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.83.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://update.code.visualstudio.com/1.83.1/win32/stable'
  url64bit       = 'https://update.code.visualstudio.com/1.83.1/win32-x64/stable'

  softwareName   = "$softwareName"

  checksum       = '6b5830991395299b59d1d8f4ecb3a9d752ef64b9b39c5dd4be848851c87f3126'
  checksumType   = 'sha256'
  checksum64     = '4ce748cdd111d88e1b7990641912a0e55904709a2cc85a72895ee6d7aa1801fd'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
