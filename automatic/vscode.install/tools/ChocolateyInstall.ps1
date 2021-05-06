$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.56.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/cfa2e218100323074ac1948c885448fdf4de2a7f/VSCodeSetup-ia32-1.56.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/cfa2e218100323074ac1948c885448fdf4de2a7f/VSCodeSetup-x64-1.56.0.exe'

  softwareName   = "$softwareName"

  checksum       = '5f540552f1fc84977be63e2c4eb4f0fab7a0c527d41a957880afdee0644ce114'
  checksumType   = 'sha256'
  checksum64     = '9719979567f6788bcddc675df29a028e995c2724b7a714280c1e14302c2d6faa'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
