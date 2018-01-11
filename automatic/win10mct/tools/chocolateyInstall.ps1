$ErrorActionPreference = 'Stop'
$exeName = "MediaCreationTool.exe"

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName  = $env:chocolateyinstall
  FileFullPath = "$toolsDir\$exeName"
  Url          = 'https://download.microsoft.com/download/A/B/E/ABEE70FE-7DE8-472A-8893-5F69947DE0B1/MediaCreationTool.exe'
  Checksum     = ''
  ChecksumType = ''
}
Get-ChocolateyWebFile @packageArgs

Register-Application "$toolsDir\$exeName"
