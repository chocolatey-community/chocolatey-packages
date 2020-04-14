$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.44.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/a9f8623ec050e5f0b44cc8ce8204a1455884749f/VSCodeSetup-ia32-1.44.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/a9f8623ec050e5f0b44cc8ce8204a1455884749f/VSCodeSetup-x64-1.44.1.exe'

  softwareName   = "$softwareName"

  checksum       = 'f33612e1134c8004e3a76f210b868078d4a779911fccc9d09ff2cdaf259efa46'
  checksumType   = 'sha256'
  checksum64     = '690d18ad40980eb691442201d455fc5eea9f3ad02e6a872070c947a278480a14'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
