$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.54.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/f30a9b73e8ffc278e71575118b6bf568f04587c8/VSCodeSetup-ia32-1.54.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/f30a9b73e8ffc278e71575118b6bf568f04587c8/VSCodeSetup-x64-1.54.1.exe'

  softwareName   = "$softwareName"

  checksum       = '9cd3f4e93e47ce97a03a964436713000a3cf1ff6b1f5554d6ae152eff7181325'
  checksumType   = 'sha256'
  checksum64     = '4975b708b45e9e6b22f8331ca09115b9cd7e8fb6e50765771e7f9775b9195ddc'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
