$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

Get-ChocolateyUnzip `
    -PackageName $env:ChocolateyPackageName `
    -File "$toolsDir\umlet-standalone-15.1.zip" `
    -UnzipLocation $toolsDir

Write-Warning 'To run UMLet you need to install a Java Runtime (e.g. Temurin8jre)'
