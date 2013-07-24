$packageName = 'autohotkey_l.portable'
$url = '{{DownloadUrl}}'
$unzipLocation = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url64 = '{{DownloadUrlx64}}'

Install-ChocolateyZipPackage $packageName $url $unzipLocation $url64