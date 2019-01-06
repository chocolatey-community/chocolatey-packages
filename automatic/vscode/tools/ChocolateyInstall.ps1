$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.30.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/dea8705087adb1b5e5ae1d9123278e178656186a/VSCodeSetup-ia32-1.30.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/dea8705087adb1b5e5ae1d9123278e178656186a/VSCodeSetup-x64-1.30.1.exe'

  softwareName   = "$softwareName"

  checksum       = '910e930042f3d36e10c2df999e94b0833f4e6c67dda3867b0640e08318eb7c07'
  checksumType   = 'sha256'
  checksum64     = 'dd7d1380393a785529525dac128de4046d3c2b2181cec6b85d6840fbc81065dc'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
