$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.48.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/3dd905126b34dcd4de81fa624eb3a8cbe7485f13/VSCodeSetup-ia32-1.48.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/3dd905126b34dcd4de81fa624eb3a8cbe7485f13/VSCodeSetup-x64-1.48.1.exe'

  softwareName   = "$softwareName"

  checksum       = '50790cb2bbce144956f5f6e699fef542abf85cfb17e0d2dcf20e1596710a0f3e'
  checksumType   = 'sha256'
  checksum64     = '5a62ffb1cf32176ae398c40911d597854d78c057dc5a9d287cbe63115a4b6803'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
