$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.74.2'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/e8a3071ea4344d9d48ef8a4df2c097372b0c5161/VSCodeSetup-ia32-1.74.2.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/e8a3071ea4344d9d48ef8a4df2c097372b0c5161/VSCodeSetup-x64-1.74.2.exe'

  softwareName   = "$softwareName"

  checksum       = 'b9eea2160c9be00bcf19032237bca70ea3ccde5571d4af77b7c7f156e6f5709b'
  checksumType   = 'sha256'
  checksum64     = '97c2dd6fa80f50078e10ce0cb7b72a1a0b1568616610639e30970d967ca68741'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
