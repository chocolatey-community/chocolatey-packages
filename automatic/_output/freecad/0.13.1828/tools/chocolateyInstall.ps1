$packageName = 'freecad'
$fileType = 'msi'
$silentArgs = '/quiet'
$url = 'http://switch.dl.sourceforge.net/project/free-cad/FreeCAD Windows/FreeCAD 0.13/FreeCAD_0.13.1828_x86_setup.msi'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url