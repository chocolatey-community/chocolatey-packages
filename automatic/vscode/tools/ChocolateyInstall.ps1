$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.37.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/036a6b1d3ac84e5ca96a17a44e63a87971f8fcc8/VSCodeSetup-ia32-1.37.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/036a6b1d3ac84e5ca96a17a44e63a87971f8fcc8/VSCodeSetup-x64-1.37.0.exe'

  softwareName   = "$softwareName"

  checksum       = 'fa78898651537eb782e94842770036dd255167d36f60767a60dd6cd77fc96cde'
  checksumType   = 'sha256'
  checksum64     = 'c54cf2a4a9bddb2fdadc709fd1a5a8df886b38c8e6a83eab1588624da761a0d7'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
