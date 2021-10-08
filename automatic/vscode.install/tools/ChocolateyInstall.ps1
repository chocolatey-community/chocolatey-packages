$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.61.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/ee8c7def80afc00dd6e593ef12f37756d8f504ea/VSCodeSetup-ia32-1.61.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/ee8c7def80afc00dd6e593ef12f37756d8f504ea/VSCodeSetup-x64-1.61.0.exe'

  softwareName   = "$softwareName"

  checksum       = '8547663d9bad2013f79e4953ce64a7f779b13ea4709e560f1cb5fcdd77170855'
  checksumType   = 'sha256'
  checksum64     = '17f648f4f52c63983946da5433560880e2d818d277913c0220cfcf4834f3ba79'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
