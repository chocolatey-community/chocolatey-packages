$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.70.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/6d9b74a70ca9c7733b29f0456fd8195364076dda/VSCodeSetup-ia32-1.70.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/6d9b74a70ca9c7733b29f0456fd8195364076dda/VSCodeSetup-x64-1.70.1.exe'

  softwareName   = "$softwareName"

  checksum       = '46d17756d28389a46dbffa3664e09f0bb6acd9e47ea859fbcbc9964856032211'
  checksumType   = 'sha256'
  checksum64     = 'c3a92ee09566bfe25413b451f87dbd7f6785e25fd0cabc77009ac88ef9bb4305'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
