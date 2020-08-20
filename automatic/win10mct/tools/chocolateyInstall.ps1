$ErrorActionPreference = 'Stop'
$exeName = "MediaCreationTool.exe"

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName  = $env:chocolateyinstall
  FileFullPath = "$toolsDir\$exeName"
  Url          = 'https://software-download.microsoft.com/download/pr/8d71966f-05fd-4d64-900b-f49135257fa5/MediaCreationTool2004.exe'
  Checksum     = 'A728C401ECB5C426E7BDE1F3E331FBA26871092CF912349515FE9FA164FF406B1388B633C7491A8EBEDF911269AAEDB5E06EB95B80DFDE7273FA0D1FC033BB61'
  ChecksumType = 'sha512'
}
Get-ChocolateyWebFile @packageArgs

Register-Application "$toolsDir\$exeName"
