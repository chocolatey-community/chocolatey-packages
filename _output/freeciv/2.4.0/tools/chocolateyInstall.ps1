$packageName = 'freeciv'
$fileType = 'exe'
$silentArgs = '/S'
# DownloadUrlx64 gets “misused” here as trimmed version variable
#$url = 'http://sourceforge.net/projects/freeciv/files/Freeciv 2.4/2.4.0/Freeciv-2.4.0-win32-gtk2-setup.exe/download'
$url = 'http://sourceforge.net/projects/freeciv/files/Freeciv%202.4/2.4.0-RC2/Freeciv-2.4.0-RC2-win32-gtk2-setup.exe/download'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url