$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.58.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/2d23c42a936db1c7b3b06f918cde29561cc47cd6/VSCodeSetup-ia32-1.58.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/2d23c42a936db1c7b3b06f918cde29561cc47cd6/VSCodeSetup-x64-1.58.0.exe'

  softwareName   = "$softwareName"

  checksum       = '96d3653f4634c52d69846ce5d4ccb4ad76f84a96c8618d8da7610f1e3c49e958'
  checksumType   = 'sha256'
  checksum64     = '4b4d3dc53b1b0b1128e2d70dd184af8d9fc87b97b30407470ce2c59bb30920fb'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
