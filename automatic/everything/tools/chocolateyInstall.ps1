$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'everything'
  fileType       = 'exe'
  file           = gi "$toolsDir\*x86*.exe"
  file64         = gi "$toolsDir\*x64*.exe"
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}
Install-ChocolateyInstallPackage @packageArgs
rm $toolsDir\*Setup*.exe

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if (!$installLocation) { Write-Warning "Can't find $PackageName install location"; exit }

Write-Host "$packageName installed to '$installLocation'"
Register-Application "$installLocation\$packageName.exe"
Write-Host "$packageName registered as $packageName"

$pp = Get-PackageParameters
$pp.Keys | % { $cmd=@(". '$installLocation\Everything.exe'", '--disable-run-as-admin') } { $cmd += "--install-" + $_.ToLower() }
Write-Host "Post install command line:" $cmd
"$cmd" | iex

Write-Host "Starting $packageName"
Start-Process "$installLocation\Everything.exe" -ArgumentList "-startup"
