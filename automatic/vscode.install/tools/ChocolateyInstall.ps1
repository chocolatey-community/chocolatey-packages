$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.43.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/fe22a9645b44368865c0ba92e2fb881ff1afce94/VSCodeSetup-ia32-1.43.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/fe22a9645b44368865c0ba92e2fb881ff1afce94/VSCodeSetup-x64-1.43.1.exe'

  softwareName   = "$softwareName"

  checksum       = 'a66f472d4d107206d1f89ff399f9a168544dc06f4c18f14a9658db15bdc35832'
  checksumType   = 'sha256'
  checksum64     = 'a9aad0cb2cf46c76d59f654fabc5cb23e7fccec35b8e0a1c94b575ed0ace0d24'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
