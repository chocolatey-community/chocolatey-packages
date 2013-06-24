$packageName = 'librecad'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://kent.dl.sourceforge.net/project/librecad/Windows/1.0.3/LibreCAD-Installer_v1.0.3.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url