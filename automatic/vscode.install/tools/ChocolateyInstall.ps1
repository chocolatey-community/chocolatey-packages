$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.58.2'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/c3f126316369cd610563c75b1b1725e0679adfb3/VSCodeSetup-ia32-1.58.2.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/c3f126316369cd610563c75b1b1725e0679adfb3/VSCodeSetup-x64-1.58.2.exe'

  softwareName   = "$softwareName"

  checksum       = '7a50c987272bffe206d9266566c28be5e282ee7b694c0375eb11177454cea800'
  checksumType   = 'sha256'
  checksum64     = 'b2e4019c129765f5425e8fd9139a90c6200577754d5b35f8f83c2615f1644935'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
