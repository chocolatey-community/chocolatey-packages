$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$rubyDir =  'ruby' + ($Env:ChocolateyPackageVersion -replace '\.').Substring(0,2)

$pp = Get-PackageParameters
$installDir = if ($pp.InstallDir) { $pp.InstallDir } else { Join-Path (Get-ToolsLocation) $rubyDir }

$tasks = 'assocfiles', 'noridkinstall'
if ( !$pp.NoPath ) { $tasks += 'modpath'  }

Write-Host "Ruby is going to be installed in '$installDir'"

$packageArgs = @{
  packageName    = 'ruby'
  fileType       = 'exe'
  file           = gi "$toolsDir\*_x32.exe"
  file64         = gi "$toolsDir\*_x64.exe"
  silentArgs     = '/verysilent /dir="{0}" /tasks="{1}"' -f $installDir, ($tasks -join ',')
  validExitCodes = @(0)
  softwareName   = 'ruby *'
}
Install-ChocolateyInstallPackage @packageArgs
ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { sc "$_.ignore" }}
