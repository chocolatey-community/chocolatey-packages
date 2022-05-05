$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.67.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/57fd6d0195bb9b9d1b49f6da5db789060795de47/VSCodeSetup-ia32-1.67.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/57fd6d0195bb9b9d1b49f6da5db789060795de47/VSCodeSetup-x64-1.67.0.exe'

  softwareName   = "$softwareName"

  checksum       = '00c88f1d80c09f1a9c66de6ad35eb1370b99772c72abddf051849334bbc79a81'
  checksumType   = 'sha256'
  checksum64     = '7891e8e6c4cb7d4a83938ee3ac6333cc0788b84ea1c0f519969f5c389667e1dd'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
