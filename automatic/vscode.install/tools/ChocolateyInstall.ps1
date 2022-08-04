$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.70.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/da76f93349a72022ca4670c1b84860304616aaa2/VSCodeSetup-ia32-1.70.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/da76f93349a72022ca4670c1b84860304616aaa2/VSCodeSetup-x64-1.70.0.exe'

  softwareName   = "$softwareName"

  checksum       = '09a0eda1437312d6d0774fd425d97eb1042f7f570c3f79370765f3b3380c3e27'
  checksumType   = 'sha256'
  checksum64     = '516f9a854160193e2786830f90af5c628708a7a3d06d0b289befe2df99173573'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
