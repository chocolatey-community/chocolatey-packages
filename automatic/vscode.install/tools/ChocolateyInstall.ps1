$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.47.3'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/91899dcef7b8110878ea59626991a18c8a6a1b3e/VSCodeSetup-ia32-1.47.3.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/91899dcef7b8110878ea59626991a18c8a6a1b3e/VSCodeSetup-x64-1.47.3.exe'

  softwareName   = "$softwareName"

  checksum       = 'd7a072d92602f852c037d368a775d175cb633df96136979920bdbac86fd9c475'
  checksumType   = 'sha256'
  checksum64     = 'a228118bff1f091c107fc7707a2650a55fa74bbc0b6d39dfb6708ac557046bc8'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
