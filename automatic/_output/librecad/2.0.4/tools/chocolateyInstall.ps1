$packageName = 'librecad'
$fileType = 'exe'
$silentArgs = '/S'
$version = '2.0.4'
# {\{DownloadUrlx64}\} gets “misused” here as 32-bit download link due to limitations of Ketarin/chocopkgup
$url = 'http://sourceforge.net/projects/librecad/files/Windows/2.0.4/LibreCAD-Installer-2.0.4.exe/download'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url