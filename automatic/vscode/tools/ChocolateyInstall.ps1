$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/6a6e02cef0f2122ee1469765b704faf5d0e0d859/VSCodeSetup-ia32-1.24.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/6a6e02cef0f2122ee1469765b704faf5d0e0d859/VSCodeSetup-x64-1.24.0.exe'

  softwareName   = 'Microsoft Visual Studio Code'

  checksum       = '5132ca83ae190c2c8d990a2864d47d90568abf668c4d19c68afb562aaec1a399'
  checksumType   = 'sha256'
  checksum64     = 'b7945c17e2254fd56da42a5c26f9063e7fc26e017a6f2b82a6c25ad1384314b9'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
