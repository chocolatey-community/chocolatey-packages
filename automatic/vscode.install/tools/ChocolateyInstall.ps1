$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.50.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/d2e414d9e4239a252d1ab117bd7067f125afd80a/VSCodeSetup-ia32-1.50.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/d2e414d9e4239a252d1ab117bd7067f125afd80a/VSCodeSetup-x64-1.50.1.exe'

  softwareName   = "$softwareName"

  checksum       = '1faa43c20c2b6a317de5f5fa20066d0edf77aca952e9f1f2c731b5d4f3aa60c9'
  checksumType   = 'sha256'
  checksum64     = '0180288d4a51497224997ce0491b1f7335747df3ce858ae9f73458f81f782156'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
