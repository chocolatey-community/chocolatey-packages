$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.41.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/9579eda04fdb3a9bba2750f15193e5fafe16b959/VSCodeSetup-ia32-1.41.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/9579eda04fdb3a9bba2750f15193e5fafe16b959/VSCodeSetup-x64-1.41.0.exe'

  softwareName   = "$softwareName"

  checksum       = '4362c7c22ec5f7d486e2f1a380dde1d9eaa640e6ba75f470b1d1e9006065b165'
  checksumType   = 'sha256'
  checksum64     = '4d99e19f39f21cdeea644f099cd031a3f041f350e6dcb4c4646290fe7f9562a4'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
