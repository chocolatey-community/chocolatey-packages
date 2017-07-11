$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'codelite'
  fileType       = 'exe'
  file           = "$toolsPath\"
  file64         = "$toolsPath\"
  unzipLocation  = Get-PackageCacheLocation
  softwareName   = 'CodeLite'
  silentArgs     = '/VERYSILENT /SP- /SUPPRESSMSGBOXES'
  validExitCodes = @(0)
}

Get-ChocolateyUnzip @packageArgs

$packageArgs.Remove('file64')
$packageArgs.file = Get-ChildItem -Path $packageArgs.unzipLocation -Filter "*.exe" | select -first 1

Install-ChocolateyInstallPackage @packageArgs

Remove-Item -Force -ea 0 "$toolsPath\*.7z"
