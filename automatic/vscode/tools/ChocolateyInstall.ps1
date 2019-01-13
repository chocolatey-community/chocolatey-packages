$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.30.2'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/61122f88f0bf01e2ac16bdb9e1bc4571755f5bd8/VSCodeSetup-ia32-1.30.2.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/61122f88f0bf01e2ac16bdb9e1bc4571755f5bd8/VSCodeSetup-x64-1.30.2.exe'

  softwareName   = "$softwareName"

  checksum       = '12d99ccd00e37af10e37638fa7a5287b390ce8a5d339ba30fac11ac251e8c5e3'
  checksumType   = 'sha256'
  checksum64     = '5ae1173eb669c1f94d796ad12e1c2345246e2b91a3920561ce6cb70c346b6d34'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs

if ($pp.NoAutoUpdate) { Set-UpdateChannel 'none' }
