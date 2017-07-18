$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

if (Test-Path "$toolsPath\optipng-*win32") {
  # Remove the directory from a previous installation
  Remove-Item -Force -Recurse -ea 0 "$toolsPath\optipng-*win32"
}

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'zip'
  file           = "$toolsPath\optipng.zip"
  destination    = $toolsPath
}

Get-ChocolateyUnzip @packageArgs

Remove-Item -Force -ea 0 $packageArgs.file
