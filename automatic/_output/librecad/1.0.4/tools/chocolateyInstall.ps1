$packageName = 'librecad'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://sourceforge.net/projects/librecad/files/Windows/1.0.4/LibreCAD-Installer_v1.0.4.exe/download'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url