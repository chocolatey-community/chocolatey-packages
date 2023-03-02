$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.76.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/92da9481c0904c6adfe372c12da3b7748d74bdcb/VSCodeSetup-ia32-1.76.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/92da9481c0904c6adfe372c12da3b7748d74bdcb/VSCodeSetup-x64-1.76.0.exe'

  softwareName   = "$softwareName"

  checksum       = '6a140c21bcbc187c2fbef5cfda1fbb9646d2b0c83bfbc5fafa695ac4565b3d59'
  checksumType   = 'sha256'
  checksum64     = '33b2648a0aeb983c50906e4b5025edf7fc8243d407d285bf8f18d488f5bf6cdc'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
