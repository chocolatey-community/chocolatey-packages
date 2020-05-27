$ErrorActionPreference = 'Stop'
$exeName = "MediaCreationTool.exe"

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName  = $env:chocolateyinstall
  FileFullPath = "$toolsDir\$exeName"
  Url          = 'https://software-download.microsoft.com/download/pr/MediaCreationTool2004.exe'
  Checksum     = 'E8E1FF189F122004E9B3FCBC6FA7C418DB6F872CAA9CCE7F6B309915B3816771D8B845A462316B01F24DCEE82D4EA734D12025F1160B74A3AFC93A4A66C4E952'
  ChecksumType = 'sha512'
}
Get-ChocolateyWebFile @packageArgs

Register-Application "$toolsDir\$exeName"
