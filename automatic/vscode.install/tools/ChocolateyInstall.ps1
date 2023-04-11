$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.77.2'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/e344f1f539a80912a0e9357cec841f36ce97a4e2/VSCodeSetup-ia32-1.77.2.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/e344f1f539a80912a0e9357cec841f36ce97a4e2/VSCodeSetup-x64-1.77.2.exe'

  softwareName   = "$softwareName"

  checksum       = 'a0ddfd672bce71100c5ef482349c38b3c6b92202803acc4fb55ad70957f65233'
  checksumType   = 'sha256'
  checksum64     = '12e8a4888cf03acece34a36e5ed41ef81ae465d6db5a7a9a583b267d44d64e2e'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
