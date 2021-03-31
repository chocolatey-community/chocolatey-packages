$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.55.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/c185983a683d14c396952dd432459097bc7f757f/VSCodeSetup-ia32-1.55.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/c185983a683d14c396952dd432459097bc7f757f/VSCodeSetup-x64-1.55.0.exe'

  softwareName   = "$softwareName"

  checksum       = 'a9648e981b0dc536f927ae702207339f42cf29e3f4afef54e37b16789eb95b3b'
  checksumType   = 'sha256'
  checksum64     = 'b9777cd93925ab95817552558051df440ef051758962327a7b2615d2b161a478'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
