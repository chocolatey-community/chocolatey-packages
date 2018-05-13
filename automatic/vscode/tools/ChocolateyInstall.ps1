$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/d0182c3417d225529c6d5ad24b7572815d0de9ac/VSCodeSetup-ia32-1.23.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/d0182c3417d225529c6d5ad24b7572815d0de9ac/VSCodeSetup-x64-1.23.1.exe'

  softwareName   = 'Microsoft Visual Studio Code'

  checksum       = '0c8cfd65f9303ddbfa76277123eacc869b7e33c47642f5a33d3de5edb661a98a'
  checksumType   = 'sha256'
  checksum64     = 'e93b72baedf6fc1234e1da751b03d67631e150f4d93573db83c9f205b632e0bd'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
