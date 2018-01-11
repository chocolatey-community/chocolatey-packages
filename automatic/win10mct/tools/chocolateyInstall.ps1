$ErrorActionPreference = 'Stop'
$exeName = "MediaCreationTool.exe"

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName  = $env:chocolateyinstall
  FileFullPath = "$toolsDir\$exeName"
  Url          = ''
  Checksum     = ''
  ChecksumType = ''
}
Get-ChocolateyWebFile @packageArgs

Register-Application "$toolsDir\$exeName"
