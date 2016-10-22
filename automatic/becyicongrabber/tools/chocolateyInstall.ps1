$packageName = '{{PackageName}}'
$unzipLocation = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url = '{{DownloadUrl}}'

$language = (Get-Culture).Parent.Name
if ($language -eq 'de') {$url = $url -replace 'Eng(\.zip)', 'Ger$1'}

Install-ChocolateyZipPackage $packageName $url $unzipLocation
