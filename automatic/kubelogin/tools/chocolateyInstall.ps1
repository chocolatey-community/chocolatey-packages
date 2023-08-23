$ErrorActionPreference = 'Stop'

$packageName = 'kubelogin'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName    = $packageName
  FileFullPath64 = Get-Item $toolsPath\kubelogin_windows_amd64.zip
  Destination    = $toolsPath
}
Get-ChocolateyUnzip @packageArgs

Install-BinFile -Name 'kubectl-oidc_login' -Path "$toolsPath\$packageName.exe"

Remove-Item "$toolsPath\kubelogin_windows_amd64.zip"
