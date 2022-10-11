$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.72.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/129500ee4c8ab7263461ffe327268ba56b9f210d/VSCodeSetup-ia32-1.72.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/129500ee4c8ab7263461ffe327268ba56b9f210d/VSCodeSetup-x64-1.72.1.exe'

  softwareName   = "$softwareName"

  checksum       = 'f13939f89598385189b8675fb72fdf961a3e94c190dc2f8b808de657ce4f8d3a'
  checksumType   = 'sha256'
  checksum64     = 'b8af108df1a087d210066941c22ce1b819ae08d962f9806eee7261128f44a294'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
