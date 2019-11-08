$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.40.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/86405ea23e3937316009fc27c9361deee66ffbf5/VSCodeSetup-ia32-1.40.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/86405ea23e3937316009fc27c9361deee66ffbf5/VSCodeSetup-x64-1.40.0.exe'

  softwareName   = "$softwareName"

  checksum       = 'abfdae3d8a4a500adc5f42deebf7bd8161e02fe47bf31eb8abf086c9a22ee774'
  checksumType   = 'sha256'
  checksum64     = 'b6229fb453e455ef075e9fe164e449127bb12a2911f1560f908f5faf48939982'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
