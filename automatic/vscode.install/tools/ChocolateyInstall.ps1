$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.49.3'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/2af051012b66169dde0c4dfae3f5ef48f787ff69/VSCodeSetup-ia32-1.49.3.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/2af051012b66169dde0c4dfae3f5ef48f787ff69/VSCodeSetup-x64-1.49.3.exe'

  softwareName   = "$softwareName"

  checksum       = '4b41b5f472b1b017b81e46b2259d6d1e3857b87ae1e64357e330a8077defe615'
  checksumType   = 'sha256'
  checksum64     = 'faf7a88448ff7234f504b4d477a106b67f0cdf26f39b3757932ab871168b74ae'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
