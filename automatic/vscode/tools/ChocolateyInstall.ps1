$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.31.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/7c66f58312b48ed8ca4e387ebd9ffe9605332caa/VSCodeSetup-ia32-1.31.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/7c66f58312b48ed8ca4e387ebd9ffe9605332caa/VSCodeSetup-x64-1.31.0.exe'

  softwareName   = "$softwareName"

  checksum       = '85471c4a8e1d487f3899ebd1f27361b4ae8e1e07067d12362a1edf3cde114547'
  checksumType   = 'sha256'
  checksum64     = '0a74a0ed2db2cafc2e65072ce7350190d3797d35a0c2fba72c7de52546ef7e87'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
