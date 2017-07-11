$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$installLocation = GetInstallLocation "$toolsPath\.."

if ($installLocation) {
  Write-Host "Uninstalling previous version of php..."
  UninstallPackage -libDirectory "$toolsPath\.." -packageName 'php'
  Uninstall-ChocolateyPath $installLocation
}

$pp = Get-PackageParameters

$downloadInfo = GetDownloadInfo -downloadInfoFile "$toolsPath\downloadInfo.csv" -parameters $pp

if (!(UrlExists($downloadInfo.URL32))) {
    Write-Host "Using archive urls"
    $downloadInfo.URL32 = AddArchivePathToUrl($downloadInfo.URL32)
    $downloadInfo.URL64 = AddArchivePathToUrl($downloadInfo.URL64) # Assuming the 64 bit version is archived simultaneously as the 32 bit one
}

$packageArgs = @{
  packageName    = 'php'
  url            = $downloadInfo.URL32
  url64Bit       = $downloadInfo.URL64
  checksum       = $downloadInfo.Checksum32
  checksum64     = $downloadInfo.Checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}
$newInstallLocation = $packageArgs.unzipLocation = GetNewInstallLocation $packageArgs.packageName $env:ChocolateyPackageVersion $pp

Install-ChocolateyZipPackage @packageArgs

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
  cp $newInstallLocation/php.ini-production $php_ini_path

  Write-Host 'Configuring PHP extensions directory'
  (gc $php_ini_path) -replace '; extension_dir = "ext"', 'extension_dir = "ext"' | sc $php_ini_path
}

if (!$pp.ThreadSafe) { Write-Host 'Please make sure you have CGI installed in IIS for local hosting' }
