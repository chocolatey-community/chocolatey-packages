$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.64.2'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/f80445acd5a3dadef24aa209168452a3d97cc326/VSCodeSetup-ia32-1.64.2.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/f80445acd5a3dadef24aa209168452a3d97cc326/VSCodeSetup-x64-1.64.2.exe'

  softwareName   = "$softwareName"

  checksum       = 'f6498a4791c19010c6173c7e6db57fa10cab22e523018c4c5e30f2c35e740784'
  checksumType   = 'sha256'
  checksum64     = 'e5a3f05161594e643c3848407d6ec82da66cadc1390bb4736661c23bc19f4abe'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
