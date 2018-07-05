$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$pp = Get-PackageParameters
Close-VSCode

$packageArgs = @{
  packageName    = 'vscode'
  fileType       = 'exe'
  url            = 'https://az764295.vo.msecnd.net/stable/0f080e5267e829de46638128001aeb7ca2d6d50e/VSCodeSetup-ia32-1.25.0.exe'
  url64bit       = 'https://az764295.vo.msecnd.net/stable/0f080e5267e829de46638128001aeb7ca2d6d50e/VSCodeSetup-x64-1.25.0.exe'

  softwareName   = 'Microsoft Visual Studio Code'

  checksum       = '984ec579805a7fcd30f992df9be14de2f9f76bcbf33ede99bfca78dbf2518774'
  checksumType   = 'sha256'
  checksum64     = '744b2180dfb90f5ff8d5a75de67313fd8544dfd9f3777cf812120bdbc5c2d3fb'
  checksumType64 = 'sha256'

  silentArgs     = '/verysilent /suppressmsgboxes /mergetasks="{0}" /log="{1}\install.log"' -f (Get-MergeTasks), (Get-PackageCacheLocation)
  validExitCodes = @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
