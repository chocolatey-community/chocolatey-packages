$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$packageArgs = @{
  packageName    = 'php'
  url            = 'http://windows.php.net//downloads/releases/php-7.0.13-nts-Win32-VC14-x86.zip'
  url64Bit       = 'http://windows.php.net//downloads/releases/php-7.0.13-nts-Win32-VC14-x64.zip'
  checksum       = '8a9a0f8a0c368ae75c398b93238b2ee14ca7746e5e265cac6d8a50ae5f9624db'
  checksum64     = '1d117986b57cc57441a3056f578ba56a7fcbb53a7cd2d7ddca7c634a6012687f'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}
$packageArgs.unzipLocation = Join-Path $(Get-ToolsLocation) $packageArgs.packageName

if (!(UrlExists($packageArgs.url))) {
    Write-Host "Using archive urls"
    $url   = AddArchivePathToUrl($url)
    $url64 = AddArchivePathToUrl($url64) # Assuming the 64 bit version is archived simultaneously as the 32 bit one
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyPath $packageArgs.unzipLocation

write-host 'Please make sure you have CGI installed in IIS for local hosting'
