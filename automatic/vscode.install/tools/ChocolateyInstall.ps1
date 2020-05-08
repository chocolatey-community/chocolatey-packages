$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.45.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/d69a79b73808559a91206d73d7717ff5f798f23c/VSCodeSetup-ia32-1.45.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/d69a79b73808559a91206d73d7717ff5f798f23c/VSCodeSetup-x64-1.45.0.exe'

  softwareName   = "$softwareName"

  checksum       = 'e2e1b288ee6395d664a6dc89bb63480bf988a21abb8c9ac00c8b7b5431827c15'
  checksumType   = 'sha256'
  checksum64     = '8bd37c380508687c5c09f48bae6fc965e77eddcfe4ea87133d280adf295f65f8'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
