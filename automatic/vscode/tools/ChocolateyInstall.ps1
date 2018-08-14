$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.26.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/4e9361845dc28659923a300945f84731393e210d/VSCodeSetup-ia32-1.26.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/4e9361845dc28659923a300945f84731393e210d/VSCodeSetup-x64-1.26.0.exe'

  softwareName   = "$softwareName"

  checksum       = 'd0462c524f29769f183bf42d4937ab9a64b56efb811131aaeb9cfdae8f517bb7'
  checksumType   = 'sha256'
  checksum64     = 'de3a74d1b9ade5541b19bc7a9f05efa00bcc028aad303ad53f37ddcfb0bced72'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
