$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
  packageName    = 'everything'
  fileType       = 'exe'
  file           = Get-Item "$toolsDir\*x86*.exe"
  file64         = Get-Item "$toolsDir\*x64*.exe"
  silentArgs     = '/S'
  validExitCodes = @(0, 1223)
}
Install-ChocolateyInstallPackage @packageArgs
Remove-Item $toolsDir\*Setup*.exe

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation $packageName
if (!$installLocation) { Write-Warning "Can't find $PackageName install location"; exit }

Write-Host "$packageName installed to '$installLocation'"
Register-Application "$installLocation\$packageName.exe"
Write-Host "$packageName registered as $packageName"

$pp = Get-PackageParameters

$cmd = @(
  ". '$installLocation\Everything.exe'"
  '--disable-run-as-admin'
  '--install-service' 
)
$pp.Keys | ? { $_ -ne 'service' } | % { $cmd += "--install-" + $_.ToLower() }
Write-Host "Post install command line:" $cmd
"$cmd" | Invoke-Expression

Write-Host "Starting $packageName"
Start-Process "$installLocation\Everything.exe" -ArgumentList "-startup"
