$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.29.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/bc24f98b5f70467bc689abf41cc5550ca637088e/VSCodeSetup-ia32-1.29.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/bc24f98b5f70467bc689abf41cc5550ca637088e/VSCodeSetup-x64-1.29.1.exe'

  softwareName   = "$softwareName"

  checksum       = 'aa291ef9b57635b98fac06ca7a75345f5d778c074bba921062233199f3a3839c'
  checksumType   = 'sha256'
  checksum64     = '25205076ecc7942b66772f8f7e275e81e89427c06a1b4bc6c9b24bb4b9ae4342'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
