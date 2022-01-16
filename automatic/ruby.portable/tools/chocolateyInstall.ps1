$ErrorActionPreference = 'Stop'
$toolsDir              = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  FileFullPath   = Join-Path $toolsDir 'rubyinstaller-3.1.0-1-x86_x32.7z'
  FileFullPath64 = Join-Path $toolsDir 'rubyinstaller-3.1.0-1-x64_x64.7z'
  Destination    = Join-Path $toolsDir 'ruby'
  PackageName    = 'ruby.portable'
}

Get-ChocolateyUnzip @packageArgs

Get-ChildItem $toolsDir\*.7z | ForEach-Object { Remove-Item $_ -ea 0 }
