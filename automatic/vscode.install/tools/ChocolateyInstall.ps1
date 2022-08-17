$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.70.2'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/e4503b30fc78200f846c62cf8091b76ff5547662/VSCodeSetup-ia32-1.70.2.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/e4503b30fc78200f846c62cf8091b76ff5547662/VSCodeSetup-x64-1.70.2.exe'

  softwareName   = "$softwareName"

  checksum       = '42abb46b8d15fdbadb358d11df4b09171646463191be0f629cdba0d723227efc'
  checksumType   = 'sha256'
  checksum64     = 'd4808bbcc8de7879eb84b8dfcbd23542e3e38502690c299078a497d23839e625'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
