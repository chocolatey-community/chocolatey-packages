$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.40.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/8795a9889db74563ddd43eb0a897a2384129a619/VSCodeSetup-ia32-1.40.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/8795a9889db74563ddd43eb0a897a2384129a619/VSCodeSetup-x64-1.40.1.exe'

  softwareName   = "$softwareName"

  checksum       = 'f7d6f5a4b3d394efcbdb9834215646cb56d02e95dcffff062971d233f82459bb'
  checksumType   = 'sha256'
  checksum64     = '4b1532c56b88942080650e27d748e55cbe810a7df53dc124ed6f5dbae2d8676d'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
