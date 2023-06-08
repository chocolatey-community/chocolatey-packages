$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.79.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/b380da4ef1ee00e224a15c1d4d9793e27c2b6302/VSCodeSetup-ia32-1.79.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/b380da4ef1ee00e224a15c1d4d9793e27c2b6302/VSCodeSetup-x64-1.79.0.exe'

  softwareName   = "$softwareName"

  checksum       = 'f2ed89e9bd4baefdb4da73aa2d0c3f32d3584a6f7b2fa903c42aa5e30b903b58'
  checksumType   = 'sha256'
  checksum64     = '92ac821c7e74231fc4f4713db138ccc257a30cdebbd11e16e184657b26e2076b'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
