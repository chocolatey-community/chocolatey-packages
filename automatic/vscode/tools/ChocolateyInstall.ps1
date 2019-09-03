$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.37.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/f06011ac164ae4dc8e753a3fe7f9549844d15e35/VSCodeSetup-ia32-1.37.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/f06011ac164ae4dc8e753a3fe7f9549844d15e35/VSCodeSetup-x64-1.37.1.exe'

  softwareName   = "$softwareName"

  checksum       = 'ee86693f9ed247bb17d383981e3bcd062190c07288812fede80ce2524937b9cd'
  checksumType   = 'sha256'
  checksum64     = '2d9cca1da13705e79c257f77cdba508763addd3a42f5424df350ffb965c315f0'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
