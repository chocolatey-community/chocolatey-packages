$packageName = 'freeciv'
$fileType = 'exe'
$silentArgs = '/S'
# DownloadUrlx64 gets “misused” here as trimmed version variable
$url = 'http://sourceforge.net/projects/freeciv/files/Freeciv 2.4/2.4.1/Freeciv-2.4.1-win32-gtk2-setup.exe/download'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url