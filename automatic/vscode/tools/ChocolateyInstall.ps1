$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$version = '1.25.1'
if ($version -eq (Get-VSCodeVersion)) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/1dfc5e557209371715f655691b1235b6b26a06be/VSCodeSetup-ia32-1.25.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/1dfc5e557209371715f655691b1235b6b26a06be/VSCodeSetup-x64-1.25.1.exe'

  softwareName   = 'Microsoft Visual Studio Code'

  checksum       = 'a270b0d9ae6782cc59999efb68a56883eaab2e0e115b4c6e8403c0bf95ec4616'
  checksumType   = 'sha256'
  checksum64     = '8b1bdf4d46c1e97a4f8df07665f1d194c45cc0f6a0360052e719b1bbd48f96fb'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
