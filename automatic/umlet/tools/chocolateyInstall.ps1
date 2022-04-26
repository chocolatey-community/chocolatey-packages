$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

Install-ChocolateyZipPackage `
    -PackageName $env:ChocolateyPackageName `
    -File "$toolsDir\umlet-standalone-15.0.0.zip" `
    -UnzipLocation $toolsDir
