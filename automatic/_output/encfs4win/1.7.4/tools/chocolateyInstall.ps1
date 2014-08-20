$packageName = 'encfs4win'
$url = 'http://members.ferrara.linux.it/freddy77/encfs.zip'
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage $packageName $url $unzipLocation