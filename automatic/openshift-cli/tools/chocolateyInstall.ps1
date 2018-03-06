$ErrorActionPreference = 'Stop'

$packageName = 'openshift-cli'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName    = $packageName
  FileFullPath64 = Get-Item $toolsPath\openshift-origin-client-tools.zip
  Destination    = $toolsPath
}
Get-ChocolateyUnzip @packageArgs
