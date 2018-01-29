$ErrorActionPreference = 'Stop'

$packageName = 'kubernetes-kompose'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$installLocation = "$(Get-ToolsLocation)\$packageName"

$packageArgs1 = @{
  PackageName    = $packageName
  FileFullPath64 = Get-Item $toolsPath\*.exe.tar.gz
  Destination    = $installLocation
}
Get-ChocolateyUnzip @packageArgs1

$packageArgs2 = @{
  PackageName    = $packageName
  FileFullPath64 = Get-Item $installLocation\*.exe.tar
  Destination    = $installLocation
}
Get-ChocolateyUnzip @packageArgs2

New-Item -ItemType "directory" -Path "$installLocation\bin"
Move-Item "$installLocation\kompose*.exe" "$installLocation\bin\kompose.exe"
Install-ChocolateyPath "$installLocation\bin"

Remove-Item "$installLocation\*.tar"
