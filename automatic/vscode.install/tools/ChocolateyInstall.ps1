$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.47.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/d5e9aa0227e057a60c82568bf31c04730dc15dcd/VSCodeSetup-ia32-1.47.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/d5e9aa0227e057a60c82568bf31c04730dc15dcd/VSCodeSetup-x64-1.47.0.exe'

  softwareName   = "$softwareName"

  checksum       = 'f9412c094325200a503ba7e551afdf2436fbd1634ef10ebafb96d7df49fa8151'
  checksumType   = 'sha256'
  checksum64     = '2bcccc2474b9e5190c223f0d6fdacf6c1aa339b2baec8074fd834f992374c9b7'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
