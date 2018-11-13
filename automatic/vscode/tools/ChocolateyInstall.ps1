$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.29.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/5f24c93878bd4bc645a4a17c620e2487b11005f9/VSCodeSetup-ia32-1.29.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/5f24c93878bd4bc645a4a17c620e2487b11005f9/VSCodeSetup-x64-1.29.0.exe'

  softwareName   = "$softwareName"

  checksum       = 'da13d5132f11775bd848c311a575b08bc1c31695f276d86556e2627411851a22'
  checksumType   = 'sha256'
  checksum64     = '4610fd9dc7cd7940cfd2a4d49a3d44c630c6eb2ef2fac3e93851fa0d67a9ff5d'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
