$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/S'
#$url = "http://www.bennewitz.com/bluefish/stable/binaries/win32/Bluefish-2.2.4-setup.exe"
$url = '{{DownloadUrl}}'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url