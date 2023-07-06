$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.80.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/660393deaaa6d1996740ff4880f1bad43768c814/VSCodeSetup-ia32-1.80.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/660393deaaa6d1996740ff4880f1bad43768c814/VSCodeSetup-x64-1.80.0.exe'

  softwareName   = "$softwareName"

  checksum       = '8c7546f28bc47b90ba877009925f820a17db713344f50caa7ebc38510be16ef2'
  checksumType   = 'sha256'
  checksum64     = '90bf319e15ab3818616292d864b2b5e41edc75020b9b1c4d6a0a5271ef8aec38'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
