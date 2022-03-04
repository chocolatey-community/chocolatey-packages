$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.65.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/b5205cc8eb4fbaa726835538cd82372cc0222d43/VSCodeSetup-ia32-1.65.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/b5205cc8eb4fbaa726835538cd82372cc0222d43/VSCodeSetup-x64-1.65.0.exe'

  softwareName   = "$softwareName"

  checksum       = 'c80295b7a535734412c29fd88ec99cf2732e14fda4903ee89396a6677a683937'
  checksumType   = 'sha256'
  checksum64     = 'f885905ebdc6a79e9034ce513d8694a31e3877b66debf3e99a86776d10cf7467'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
