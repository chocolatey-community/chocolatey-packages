$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.28.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/3368db6750222d319c851f6d90eb619d886e08f5/VSCodeSetup-ia32-1.28.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/3368db6750222d319c851f6d90eb619d886e08f5/VSCodeSetup-x64-1.28.1.exe'

  softwareName   = "$softwareName"

  checksum       = 'eb9d8e279c5c11bcc2f5dace107512f54f2f087e8d3dc0d54bf9760b1122a364'
  checksumType   = 'sha256'
  checksum64     = '8955dd893e35c15add27817bdb7328b115f4721b66ae8d77fd1631e272d761e7'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
