$packageName = 'freecad'
$fileType = 'exe'
$silentArgs = '/S'
# {\{DownloadUrlx64}\} gets “misused” here as array of the download
# links due to limitations of Ketarin/chocopkgup
$urlArray = @('http://sourceforge.net/projects/free-cad/files/FreeCAD%20Windows/FreeCAD%200.14/FreeCAD%200.14.3700_x86_setup.exe/download', 'http://sourceforge.net/projects/free-cad/files/FreeCAD%20Windows/FreeCAD%200.14/FreeCAD-0.14.3700_x64_setup.exe/download')
$url = $urlArray[0]
$url64 = $urlArray[1]

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64