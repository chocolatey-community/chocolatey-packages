$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName = $env:ChocolateyPackageName
  file        = "$toolsPath\Ketarin-1.8.9.zip"
  destination = $toolsPath
}

Get-ChocolateyUnzip @packageArgs
Set-Content -Path "$toolsPath\Ketarin.exe.gui" -Value ""
Remove-Item $toolsPath\*.zip -ea 0
