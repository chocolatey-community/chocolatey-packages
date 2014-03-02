$packageName = 'nircmd'
$url = 'http://www.nirsoft.net/utils/nircmd.zip'
$url64 = 'http://www.nirsoft.net/utils/nircmd-x64.zip'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage $packageName $url $unzipLocation $url64