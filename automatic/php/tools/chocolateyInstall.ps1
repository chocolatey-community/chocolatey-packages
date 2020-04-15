$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$installLocation = GetInstallLocation "$toolsPath\.."

if ($installLocation) {
  Write-Host "Uninstalling previous version of php..."
  UninstallPackage -libDirectory "$toolsPath\.." -packageName $env:ChocolateyPackageName
  Uninstall-ChocolateyPath $installLocation
}

$pp = Get-PackageParameters

$filesInfo = @{
  filets32  = "$toolsPath\php-7.2.30-Win32-VC15-x86.zip"
  filets64  = "$toolsPath\php-7.2.30-Win32-VC15-x64.zip"
  filents32 = "$toolsPath\php-7.2.30-nts-Win32-VC15-x86.zip"
  filents64 = "$toolsPath\php-7.2.30-nts-Win32-VC15-x64.zip"
}

if ($pp.ThreadSafe) {
  $file32 = $filesInfo.filets32
  $file64 = $filesInfo.filets64
} else {
  $file32 = $filesInfo.filents32
  $file64 = $filesInfo.filents64
}

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  file           = $file32
  file64         = $file64
}

$newInstallLocation = $packageArgs.Destination = GetNewInstallLocation $packageArgs.packageName $env:ChocolateyPackageVersion $pp

Get-ChocolateyUnzip @packageArgs

Get-ChildItem $toolsPath\*.zip | ForEach-Object { Remove-Item $_ -ea 0; if (Test-Path $_) { Set-Content "$_.ignore" } }

if (!$pp.DontAddToPath) { Install-ChocolateyPath $newInstallLocation 'Machine' }

$php_ini_path = $newInstallLocation + '/php.ini'

if (($installLocation -ne $newInstallLocation) -and (Test-Path "$installLocation\php.ini")) {
  Write-Host "Moving old configuration file."
  Move-Item "$installLocation\php.ini" "$php_ini_path"

  $di = Get-ChildItem $installLocation -ea 0 | Measure-Object
  if ($di.Count -eq 0) {
    Write-Host "Removing old install location."
    Remove-Item -Force -ea 0 $installLocation
  }
}

if (!(Test-Path $php_ini_path)) {
  Write-Host 'Creating default php.ini'
  Copy-Item $newInstallLocation/php.ini-production $php_ini_path

  Write-Host 'Configuring PHP extensions directory'
  (Get-Content $php_ini_path) -replace ';\s?extension_dir = "ext"', 'extension_dir = "ext"' | Set-Content $php_ini_path
}

if (!$pp.ThreadSafe) { Write-Host 'Please make sure you have CGI installed in IIS for local hosting' }
