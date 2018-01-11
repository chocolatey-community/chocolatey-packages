$ErrorActionPreference = 'Stop'
$exeName = "MediaCreationTool.exe"

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName  = $env:chocolateyinstall
  FileFullPath = "$toolsDir\$exeName"
  Url          = 'https://download.microsoft.com/download/A/B/E/ABEE70FE-7DE8-472A-8893-5F69947DE0B1/MediaCreationTool.exe'
  Checksum     = 'B83CB0E7938BBECFCD12FAC51CFFCAB859599D9CD99376B9427AD316E01D76754C3E947DF50FE0978097A30B5BE562EA2F3C47140526608276E3609BA252EB56'
  ChecksumType = 'sha512'
}
Get-ChocolateyWebFile @packageArgs

Register-Application "$toolsDir\$exeName"
