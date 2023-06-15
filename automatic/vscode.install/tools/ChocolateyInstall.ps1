$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.79.2'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/695af097c7bd098fbf017ce3ac85e09bbc5dda06/VSCodeSetup-ia32-1.79.2.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/695af097c7bd098fbf017ce3ac85e09bbc5dda06/VSCodeSetup-x64-1.79.2.exe'

  softwareName   = "$softwareName"

  checksum       = 'b06e9ae63b8eee6024babc7bbe4f1827e4ad7223438c340fdf41600b2847203b'
  checksumType   = 'sha256'
  checksum64     = 'b9468afa773c04182ee7387450b29e164c5e68894d7f03e367ef354e609428e4'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
