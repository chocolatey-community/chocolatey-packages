$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.38.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/3db7e09f3b61f915d03bbfa58e258d6eee843f35/VSCodeSetup-ia32-1.38.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/3db7e09f3b61f915d03bbfa58e258d6eee843f35/VSCodeSetup-x64-1.38.0.exe'

  softwareName   = "$softwareName"

  checksum       = '83a1fb4d7efa99aabb95b69ae39b2530593c9a53cff8391a4beca84caf5cc097'
  checksumType   = 'sha256'
  checksum64     = '717343701e6d4068019c6d141f9168934487f362ef3e318e0ec6c4c7e17723cf'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
