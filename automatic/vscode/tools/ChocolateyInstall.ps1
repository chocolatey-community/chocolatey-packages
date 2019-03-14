$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.32.2'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/e64cb27b1a0cbbc3f643c9fc6c7d93d6c6509951/VSCodeSetup-ia32-1.32.2.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/e64cb27b1a0cbbc3f643c9fc6c7d93d6c6509951/VSCodeSetup-x64-1.32.2.exe'

  softwareName   = "$softwareName"

  checksum       = 'cdb733c7cf26b74e3735d6f2ab0450ada64bfa754c7c523e850c662a23b7babc'
  checksumType   = 'sha256'
  checksum64     = '7b7fbfe7198b8dc1cfefbf4f9b5e9e900c26f1997ec6dd5a2256ca8e269b087e'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
