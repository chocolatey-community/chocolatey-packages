$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.43.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/78a4c91400152c0f27ba4d363eb56d2835f9903a/VSCodeSetup-ia32-1.43.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/78a4c91400152c0f27ba4d363eb56d2835f9903a/VSCodeSetup-x64-1.43.0.exe'

  softwareName   = "$softwareName"

  checksum       = 'c0eb98a547a8769e2e633e5dad1ff655e7cdae2caf38a663980fc33c067c251b'
  checksumType   = 'sha256'
  checksum64     = 'f1574dee870ee71c3bc87b0e1ab7d9f813513e6d60418f9a146f3b369555eb3e'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
