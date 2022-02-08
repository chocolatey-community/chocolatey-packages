$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.64.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/d6ee99e4c045a6716e5c653d7da8e9ae6f5a8b03/VSCodeSetup-ia32-1.64.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/d6ee99e4c045a6716e5c653d7da8e9ae6f5a8b03/VSCodeSetup-x64-1.64.1.exe'

  softwareName   = "$softwareName"

  checksum       = '7380307a2db822aad8cbc827cef9add76e538566e26adfb47e33f33236e191a2'
  checksumType   = 'sha256'
  checksum64     = 'd31a70f5f31c2c3ecb10e5056bd3aab09d600f8699cab6f5f06ba82eb765ee60'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
