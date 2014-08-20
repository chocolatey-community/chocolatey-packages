$packageName = 'freeciv'
$fileType = 'exe'
$silentArgs = '/S'
# {\{DownloadUrlx64}\} gets “misused” here as 32-bit download link due to limitations of Ketarin/chocopkgup
$url = 'http://sourceforge.net/projects/freeciv/files/Freeciv%202.4/2.4.3/Freeciv-2.4.3-win32-gtk2-setup.exe/download'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url