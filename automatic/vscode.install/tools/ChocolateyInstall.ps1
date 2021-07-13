$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.58.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/2aeda6b18e13c4f4f9edf6667158a6b8d408874b/VSCodeSetup-ia32-1.58.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/2aeda6b18e13c4f4f9edf6667158a6b8d408874b/VSCodeSetup-x64-1.58.1.exe'

  softwareName   = "$softwareName"

  checksum       = '938ecef4da73ac5f96d33808ea97bbdacb793270a8cdb5198446e5a57742a5ca'
  checksumType   = 'sha256'
  checksum64     = 'ffa61991069102953e0f21f36c774fff57313e25d79b83be39803aa2f632137e'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
