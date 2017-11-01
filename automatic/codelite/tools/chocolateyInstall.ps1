$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'codelite'
  fileType       = 'exe'
  file           = "$toolsPath\codelite-x86-11.0.0.7z"
  file64         = "$toolsPath\codelite-amd64-11.0.1.7z"
  destination    = Get-PackageCacheLocation
  softwareName   = 'CodeLite'
  silentArgs     = '/VERYSILENT /SP- /SUPPRESSMSGBOXES'
  validExitCodes = @(0)
}

Get-ChocolateyUnzip @packageArgs

$packageArgs.Remove('file64')
$packageArgs.file = Get-ChildItem -Path $packageArgs.destination -Filter "*.exe" | select -first 1 -expand FullName

Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force -ea 0 "$toolsPath\*.7z"
