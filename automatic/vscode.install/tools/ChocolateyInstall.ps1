$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.51.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/fcac248b077b55bae4ba5bab613fd6e9156c2f0c/VSCodeSetup-ia32-1.51.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/fcac248b077b55bae4ba5bab613fd6e9156c2f0c/VSCodeSetup-x64-1.51.0.exe'

  softwareName   = "$softwareName"

  checksum       = '60ea455923a189c038aedfec1bf0932e97fa09dc54a5fb4c2211b395b57bcbfb'
  checksumType   = 'sha256'
  checksum64     = '5c33dc593168aa8bbf8ba48b11d005457a88668be6ad5e4674b3b69c4a3af118'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
