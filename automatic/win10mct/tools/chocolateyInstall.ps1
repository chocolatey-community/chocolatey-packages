$ErrorActionPreference = 'Stop'
$exeName = "MediaCreationTool.exe"

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName  = $env:chocolateyinstall
  FileFullPath = "$toolsDir\$exeName"
  Url          = 'https://download.microsoft.com/download/4/c/c/4cc6c15c-75a5-4d1b-a3fe-140a5e09c9ff/MediaCreationTool20H2.exe'
  Checksum     = 'FAB34CCBEFBCDCEC8F823840C16AE564812D0E063319C4EB4CC1112CF775B8764FEA59D0BBAFD4774D84B56E08C24056FA96F27425C4060E12EB547C2AE086CC'
  ChecksumType = 'sha512'
}
Get-ChocolateyWebFile @packageArgs

Register-Application "$toolsDir\$exeName"
