$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.56.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/e713fe9b05fc24facbec8f34fb1017133858842b/VSCodeSetup-ia32-1.56.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/e713fe9b05fc24facbec8f34fb1017133858842b/VSCodeSetup-x64-1.56.1.exe'

  softwareName   = "$softwareName"

  checksum       = '5cfb68c9e313f4755368cf71db617072968a66ca9e73828ae250ecd5f7f65a22'
  checksumType   = 'sha256'
  checksum64     = '5e2b0047dba0cf47a4e8aa76aa4a275f69e9d1fb6e39b53b5a536ea7e1442580'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
