$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
$rubyDir =  'ruby' + ($Env:ChocolateyPackageVersion -replace '\.').Substring(0,2)

$pp = Get-PackageParameters
$installDir = if ($pp.InstallDir) { $pp.InstallDir } else { Get-ToolsLocation }
$installDir = Join-Path $installDir $rubyDir
Write-Host "Ruby is going to be installed in '$installDir'"

$packageArgs = @{
  packageName    = 'ruby'
  fileType       = 'exe'
  file           = gi "$toolsDir\*_x32.exe"
  file64         = gi "$toolsDir\*_x64.exe"
  silentArgs     = '/verysilent /dir="{0}" /tasks="assocfiles, modpath, noridkinstall"' -f $installDir
  validExitCodes = @(0)
  softwareName   = 'ruby *'
}
Install-ChocolateyInstallPackage @packageArgs
rm $toolsDir\*.exe -ea 0

if (!$pp.NoPath) { Install-ChocolateyPath (Join-Path $installDir 'bin') Machine }
