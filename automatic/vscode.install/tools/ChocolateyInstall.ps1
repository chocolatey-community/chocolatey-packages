$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.83.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://update.code.visualstudio.com/1.83.0/win32/stable'
  url64bit       = 'https://update.code.visualstudio.com/1.83.0/win32-x64/stable'

  softwareName   = "$softwareName"

  checksum       = '052b4d25d9ed1e237e4dc58ec3280f16619930227f7f5ec51a898ef0dbcf3e75'
  checksumType   = 'sha256'
  checksum64     = '507269bb0e9806243088815af19a6aff9a9f18907d88c1a6368f9cba758b0da2'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
