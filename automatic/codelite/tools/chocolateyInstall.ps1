$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'codelite'
  fileType       = 'exe'
  file           = "$toolsPath\codelite-x86-12.0.0.exe.7z"
  file64         = "$toolsPath\codelite-amd64-12.0.0.exe.7z"
  destination    = Get-PackageCacheLocation
  softwareName   = 'CodeLite'
  silentArgs     = '/VERYSILENT /SP- /SUPPRESSMSGBOXES'
  validExitCodes = @(0)
}

Get-ChocolateyUnzip @packageArgs

$packageArgs.Remove('file64')
$packageArgs.file = Get-ChildItem -Path $packageArgs.destination -Filter "*.exe" | Select-Object -first 1 -expand FullName

Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force -ea 0 "$toolsPath\*.7z"
