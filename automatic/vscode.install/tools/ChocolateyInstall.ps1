$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.80.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/74f6148eb9ea00507ec113ec51c489d6ffb4b771/VSCodeSetup-ia32-1.80.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/74f6148eb9ea00507ec113ec51c489d6ffb4b771/VSCodeSetup-x64-1.80.1.exe'

  softwareName   = "$softwareName"

  checksum       = 'bc4e3ffa69e4137ddd6e945f7849a9a5e977f20402f4cc23ea6a324b3cf7b27f'
  checksumType   = 'sha256'
  checksum64     = '1b541228f6e2158d32c3afcfb9e42e596abdf3e5eea4647e0b89ef065311bcc5'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
