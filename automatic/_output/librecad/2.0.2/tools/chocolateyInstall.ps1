$packageName = 'librecad'
$fileType = 'exe'
$silentArgs = '/S'
$version = '2.0.2'
$url = "http://sourceforge.net/projects/librecad/files/Windows/${version}/LibreCAD-Installer-${version}.exe/download"

Install-ChocolateyPackage $packageName $fileType $silentArgs $url