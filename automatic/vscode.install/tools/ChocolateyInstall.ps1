$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.78.1'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode.install'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/6a995c4f4cc2ced6e3237749973982e751cb0bf9/VSCodeSetup-ia32-1.78.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/6a995c4f4cc2ced6e3237749973982e751cb0bf9/VSCodeSetup-x64-1.78.1.exe'

  softwareName   = "$softwareName"

  checksum       = 'd3003cd60743928282ab6be0029940f2707fadd1ae6e22ab6c69ae64596fbff1'
  checksumType   = 'sha256'
  checksum64     = 'a64657e66ec99bf56c26626617eb4d0cf3e4ff0c37e033bcf97c8581e8d3dd15'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
