$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.36.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/0f3794b38477eea13fb47fbe15a42798e6129338/VSCodeSetup-ia32-1.36.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/0f3794b38477eea13fb47fbe15a42798e6129338/VSCodeSetup-x64-1.36.0.exe'

  softwareName   = "$softwareName"

  checksum       = '3ac2582a9185705ebdbe5d9222f25188169bdedb2173a63dbf05bf3d03af7272'
  checksumType   = 'sha256'
  checksum64     = '5b24d9b290a1cbae3ae1539825f74b7229143a0ec01754a96a3ef852985ab876'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
