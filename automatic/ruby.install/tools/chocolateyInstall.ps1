﻿$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$rubyDir = 'ruby' + ($Env:ChocolateyPackageVersion -replace '\.').Substring(0, 2)

$pp = Get-PackageParameters
$installDir = if ($pp['InstallDir']) { $pp['InstallDir'] } else { Join-Path (Get-ToolsLocation) $rubyDir }

$tasks = 'assocfiles', 'noridkinstall'
if ( !$pp['NoPath'] ) { $tasks += 'modpath' }

Write-Host "Ruby is going to be installed in '$installDir'"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  file           = "$toolsPath\rubyinstaller-3.3.5-1-x86.exe"
  file64         = "$toolsPath\rubyinstaller-3.3.5-1-x64.exe"
  silentArgs     = '/verysilent /allusers /dir="{0}" /tasks="{1}"' -f $installDir, ($tasks -join ',')
  validExitCodes = @(0)
  softwareName   = 'ruby *'
}
Install-ChocolateyInstallPackage @packageArgs
Get-ChildItem $toolsPath\*.exe | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" '' } }
