$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/24f62626b222e9a8313213fb64b10d741a326288/VSCodeSetup-ia32-1.24.1.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/24f62626b222e9a8313213fb64b10d741a326288/VSCodeSetup-x64-1.24.1.exe'

  softwareName   = 'Microsoft Visual Studio Code'

  checksum       = '1db69debf39cd1b4b0bf62bec55cf5dab31ff9b98546c6dfd587cab541b02113'
  checksumType   = 'sha256'
  checksum64     = '59a1f2f4a4d270cb36de5e5deb9de58f4e5ff3c0a76641f51832cf026481d33b'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
