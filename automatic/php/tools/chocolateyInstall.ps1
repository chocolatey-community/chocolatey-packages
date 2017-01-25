$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$installLocation = GetInstallLocation "$toolsPath\.."

if ($installLocation) {
  Write-Host "Uninstalling previous version of php..."
  UninstallLocation -libDirectory "$toolsPath\.." -packageName 'php'
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
$installLocation = $packageArgs.unzipLocation = Join-Path $(Get-ToolsLocation) $packageArgs.packageName

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyPath $installLocation

$php_ini_path = $installLocation + '/php.ini'
if (!(Test-Path $php_ini_path)) {
  Write-Host 'Creating default php.ini'
  cp $installLocation/php.ini-production $php_ini_path

  Write-Host 'Configuring PHP extensions directory'
  (gc $php_ini_path) -replace '; extension_dir = "ext"', 'extension_dir = "ext"' | sc $php_ini_path
}

Write-Host 'Please make sure you have CGI installed in IIS for local hosting'
