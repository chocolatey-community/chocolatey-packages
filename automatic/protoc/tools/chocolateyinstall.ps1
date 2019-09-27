$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  FileFullPath   = "$toolsDir\TO-BE-REPLACED"
  FileFullPath64 = "$toolsDir\TO-BE-REPLACED"

  Destination    = $toolsDir
}

Get-ChocolateyUnzip @packageArgs

# Install-BinFile 'protoc' $executableLocation
