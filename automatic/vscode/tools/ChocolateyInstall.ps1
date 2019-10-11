$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.39.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/88f15d17dca836346e787762685a40bb5cce75a8/VSCodeSetup-ia32-1.39.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/88f15d17dca836346e787762685a40bb5cce75a8/VSCodeSetup-x64-1.39.1.exe'

  softwareName   = "$softwareName"

  checksum       = '51e8bbedf4486ec57a656e30e8a03dedc9309ed6b1fca25d1493ddad07403080'
  checksumType   = 'sha256'
  checksum64     = '56fd137488ace5ac16425d4b79bff3a58b29612da2ae319ba74c3248d8e9f21a'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
