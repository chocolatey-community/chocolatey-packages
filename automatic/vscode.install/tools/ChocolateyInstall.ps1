$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.66.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/e18005f0f1b33c29e81d732535d8c0e47cafb0b5/VSCodeSetup-ia32-1.66.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/e18005f0f1b33c29e81d732535d8c0e47cafb0b5/VSCodeSetup-x64-1.66.0.exe'

  softwareName   = "$softwareName"

  checksum       = 'e588019ef622b0c181b62073d6d64dd5de04f7f125fb0b0aa30d54b2915e1637'
  checksumType   = 'sha256'
  checksum64     = 'ca2140138b7268b192dc34d5a1b0fc151344be93e824ad4fb3670c49a2fa3ba9'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
