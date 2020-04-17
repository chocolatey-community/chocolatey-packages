$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.44.2'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/ff915844119ce9485abfe8aa9076ec76b5300ddd/VSCodeSetup-ia32-1.44.2.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/ff915844119ce9485abfe8aa9076ec76b5300ddd/VSCodeSetup-x64-1.44.2.exe'

  softwareName   = "$softwareName"

  checksum       = 'c2c2ca9eedafe4290b008e25a990489431c8615b46ed8ac8cdcbc61ce1469891'
  checksumType   = 'sha256'
  checksum64     = '6479735184be6c3a2357ddae47743e85035c85cf4973854f0e78b8b0487dd8ed'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
