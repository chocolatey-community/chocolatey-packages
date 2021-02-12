$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.53.2'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/622cb03f7e070a9670c94bae1a45d78d7181fbd4/VSCodeSetup-ia32-1.53.2.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/622cb03f7e070a9670c94bae1a45d78d7181fbd4/VSCodeSetup-x64-1.53.2.exe'

  softwareName   = "$softwareName"

  checksum       = '5f2baf775c7a67cefe18a7ddd7bb0d998cd98fd97bd5f87742a113a8ecfd4e09'
  checksumType   = 'sha256'
  checksum64     = '9ef53748248e6d3e0272e2b7ef98d41bf858f7c91082bb0d10f909eb4885f679'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
