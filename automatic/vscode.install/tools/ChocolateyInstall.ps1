$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.50.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/93c2f0fbf16c5a4b10e4d5f89737d9c2c25488a3/VSCodeSetup-ia32-1.50.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/93c2f0fbf16c5a4b10e4d5f89737d9c2c25488a3/VSCodeSetup-x64-1.50.0.exe'

  softwareName   = "$softwareName"

  checksum       = '9e512056dc120512c7802d603c38167a7d4ab0810afc30435f92d43f6775c48c'
  checksumType   = 'sha256'
  checksum64     = '44a354fbf8a6c70eca8ce255c60727d6e56edd044a0208a2aa676c8877dd5221'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
