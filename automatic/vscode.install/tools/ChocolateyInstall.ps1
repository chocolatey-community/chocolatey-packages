$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.47.2'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/17299e413d5590b14ab0340ea477cdd86ff13daf/VSCodeSetup-ia32-1.47.2.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/17299e413d5590b14ab0340ea477cdd86ff13daf/VSCodeSetup-x64-1.47.2.exe'

  softwareName   = "$softwareName"

  checksum       = '2c44ced2cb45bb7d6e8fe8a1290df5db31d0a6c6143f7b0e69ba02ff737329ef'
  checksumType   = 'sha256'
  checksum64     = 'e3f51af7ad6c2b9ae66d79cef243e5e2cbce4f59d70b4cdc8b6a9914f2460d67'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
