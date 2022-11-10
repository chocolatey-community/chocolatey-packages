$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.73.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/6261075646f055b99068d3688932416f2346dd3b/VSCodeSetup-ia32-1.73.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/6261075646f055b99068d3688932416f2346dd3b/VSCodeSetup-x64-1.73.1.exe'

  softwareName   = "$softwareName"

  checksum       = 'f8ebc27fce1c7a9381a7c9094642d3714781f724c61cf0c31018528fc012dcfb'
  checksumType   = 'sha256'
  checksum64     = '47746bb858382632e699d5766c9cfec4029357748420de70136f08a515d8298a'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
