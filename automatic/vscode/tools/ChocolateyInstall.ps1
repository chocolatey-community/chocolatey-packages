$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.26.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/493869ee8e8a846b0855873886fc79d480d342de/VSCodeSetup-ia32-1.26.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/493869ee8e8a846b0855873886fc79d480d342de/VSCodeSetup-x64-1.26.1.exe'

  softwareName   = "$softwareName"

  checksum       = '30b148dd49ab80b1d00f4bfeed3fd698da449fa7a73468155dbee7d59ec7ca4c'
  checksumType   = 'sha256'
  checksum64     = 'ac33802a7b33e83d336ccb11d7010afe551fd56d9a7f39ad57afecdafaab50cd'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
