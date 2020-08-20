$ErrorActionPreference = 'Stop'

$packageName = 'kubelogin'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName    = $packageName
  FileFullPath64 = Get-Item $toolsPath\kubelogin_windows_amd64.zip
  Destination    = $toolsPath
}
Get-ChocolateyUnzip @packageArgs

Remove-Item "$toolsPath\kubelogin_windows_amd64.zip"
