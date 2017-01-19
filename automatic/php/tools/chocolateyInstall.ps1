$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageArgs = @{
  packageName    = 'php'
  url            = 'http://windows.php.net//downloads/releases/php-7.1.1-nts-Win32-VC14-x86.zip'
  url64Bit       = 'http://windows.php.net//downloads/releases/php-7.1.1-nts-Win32-VC14-x64.zip'
  checksum       = '8f5e76646cdf5f467ff66edaba74c483856c266d891df4bf54b9a1477b204098'
  checksum64     = 'f01024e53da0ff4284c3585553e44805237c7e04fcf7c0b074658f52e633df83'
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
