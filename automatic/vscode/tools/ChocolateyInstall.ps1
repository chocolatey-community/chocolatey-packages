$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.28.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/431ef9da3cf88a7e164f9d33bf62695e07c6c2a9/VSCodeSetup-ia32-1.28.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/431ef9da3cf88a7e164f9d33bf62695e07c6c2a9/VSCodeSetup-x64-1.28.0.exe'

  softwareName   = "$softwareName"

  checksum       = '487d764a9537dad72696031b84ad761b3be6ef79b1d848710a45d34301f51f49'
  checksumType   = 'sha256'
  checksum64     = '452fb89b2dd8bacb0e0388ddd5ccecb075f56858ac8cefb0d4418c84bb8028e3'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
