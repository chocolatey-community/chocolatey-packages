$ErrorActionPreference = 'Stop'
$exeName = "MediaCreationTool.exe"

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName  = $env:chocolateyinstall
  FileFullPath = "$toolsDir\$exeName"
  Url          = 'https://download.microsoft.com/download/9/8/8/9886d5ac-8d7c-4570-a3af-e887ce89cf65/MediaCreationTool1903.exe'
  Checksum     = '99D45E22F36F15777E789E54D6A5410A335BD344D009D863AFD3C35CE53A6F4811B7E40F912B6DA35725E121FFF11E51A3FB9659A45A2F7701AFC9AB407D7399'
  ChecksumType = 'sha512'
}
Get-ChocolateyWebFile @packageArgs

Register-Application "$toolsDir\$exeName"
