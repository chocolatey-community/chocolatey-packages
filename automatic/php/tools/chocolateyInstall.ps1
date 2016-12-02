$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageArgs = @{
  packageName    = 'php'
  url            = 'http://windows.php.net//downloads/releases/php-7.1.0-nts-Win32-VC14-x86.zip'
  url64Bit       = 'http://windows.php.net//downloads/releases/php-7.1.0-nts-Win32-VC14-x64.zip'
  checksum       = '0bfb7ea5a20090830377fb5e8f0b202174ec849cbbce2d04c9b6536052ad6e70'
  checksum64     = 'f51c45ac4c485db7a5b980c2dd00eed990bd50823fb5061f6a3cf730d8cadff3'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}
$installLocation = $packageArgs.unzipLocation = Join-Path $(Get-ToolsLocation) $packageArgs.packageName

if (!(UrlExists($packageArgs.url))) {
    Write-Host "Using archive urls"
    $url   = AddArchivePathToUrl($url)
    $url64 = AddArchivePathToUrl($url64) # Assuming the 64 bit version is archived simultaneously as the 32 bit one
}

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
