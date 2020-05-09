$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code Insiders'
$version = '1.46.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code Insiders $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCodeInsiders

$packageArgs = @{
  packageName    = 'vscode-insiders.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/insider/d487078dc7fc1c276657cadb61b4f63833a8df55/VSCodeSetup-ia32-1.46.0-insider.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/insider/d487078dc7fc1c276657cadb61b4f63833a8df55/VSCodeSetup-x64-1.46.0-insider.exe'

  softwareName   = "$softwareName"

  checksum       = '642736d0b4ae4e18dcb4db0c05072f9befb05497cc217312ab465c93cde90dab'
  checksumType   = 'sha256'
  checksum64     = '1dc7dba1cbd2db3db041ecadc4f0f3b3e15a88aecfc3c41fab006626986afecf'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
