$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.62.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/b3318bc0524af3d74034b8bb8a64df0ccf35549a/VSCodeSetup-ia32-1.62.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/b3318bc0524af3d74034b8bb8a64df0ccf35549a/VSCodeSetup-x64-1.62.0.exe'

  softwareName   = "$softwareName"

  checksum       = 'b794f6a3ab3046e65f3314296f6698daadad0a6950e7b1ea358c737786a04fa9'
  checksumType   = 'sha256'
  checksum64     = 'ab7c4573f2a0c93deef4f796108c9cf3189445da08473fffde68a8a7052c8f34'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
