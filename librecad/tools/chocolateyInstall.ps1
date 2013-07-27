$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://sourceforge.net/projects/librecad/files/Windows/{{PackageVersion}}/LibreCAD-Installer_v{{PackageVersion}}.exe/download'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url