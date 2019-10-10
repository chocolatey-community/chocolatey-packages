$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$softwareName = 'Microsoft Visual Studio Code'
$version = '1.39.0'
if ($version -eq (Get-UninstallRegistryKey "$softwareName").DisplayVersion) {
  Write-Host "VS Code $version is already installed."
  return
}

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/9df03c6d6ce97c6645c5846f6dfa2a6a7d276515/VSCodeSetup-ia32-1.39.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/9df03c6d6ce97c6645c5846f6dfa2a6a7d276515/VSCodeSetup-x64-1.39.0.exe'

  softwareName   = "$softwareName"

  checksum       = '82cc0fa36edd67052ad64797a8d038ede619a3a11c97d64f2b5e0ea8d0af6b38'
  checksumType   = 'sha256'
  checksum64     = 'd20bb6708317890ae01a69cda4606d5958da43662faf02d306c414c57cc7e85f'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
