$ErrorActionPreference = 'Stop'
$exeName = "MediaCreationTool.exe"

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName  = $env:chocolateyinstall
  FileFullPath = "$toolsDir\$exeName"
  Url          = 'https://software-download.microsoft.com/download/pr/MediaCreationTool1809.exe'
  Checksum     = '24BC375FC204020AA031403BCB536B5CCE92AE601F958C56F317158340CFBA6679EF765B7FBF0ABDFD1D32578DB9CCAA4826D1B1AA76ECF42913E659CE67F8A1'
  ChecksumType = 'sha512'
}
Get-ChocolateyWebFile @packageArgs

Register-Application "$toolsDir\$exeName"
