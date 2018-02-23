$ErrorActionPreference = 'Stop'

$packageName = 'kubernetes-kompose'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$installLocation = "$(Get-ToolsLocation)\$packageName"

$packageArgs = @{
  PackageName    = $packageName
  FileFullPath64 = Get-Item $toolsPath\kompose*.exe.tar.gz
  Destination    = $installLocation
}
Get-ChocolateyUnzip @packageArgs

if (!(Test-Path $installLocation -include "kompose*.exe")) {
  $packageArgs2 = @{
    PackageName    = $packageName
    FileFullPath64 = Get-Item $installLocation\kompose*.exe.tar
    Destination    = $installLocation
  }
  Get-ChocolateyUnzip @packageArgs2
}

New-Item -ItemType "directory" -Path "$installLocation\bin" -ErrorAction Ignore
Move-Item "$installLocation\kompose*.exe" "$installLocation\bin\kompose.exe"
Install-ChocolateyPath "$installLocation\bin"

Remove-Item "$installLocation\*.tar"
