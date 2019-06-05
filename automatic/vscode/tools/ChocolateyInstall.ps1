$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.35.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/553cfb2c2205db5f15f3ee8395bbd5cf066d357d/VSCodeSetup-ia32-1.35.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/553cfb2c2205db5f15f3ee8395bbd5cf066d357d/VSCodeSetup-x64-1.35.0.exe'

  softwareName   = "$softwareName"

  checksum       = '28e7995ee90845fcc1ba5c123fc6827062378c66cd4fe274b46c45ab93603c25'
  checksumType   = 'sha256'
  checksum64     = '47418a4d9d0921b5a392f205ebc1e367b6a73730ae0e35da4b50f96e17214da9'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
