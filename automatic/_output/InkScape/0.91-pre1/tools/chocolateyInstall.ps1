$packageName = 'InkScape'

$url = 'http://sourceforge.net/projects/inkscape/files/inkscape/0.91pre1/inkscape-0.91pre1.msi/download'
$url64 = 'http://sourceforge.net/projects/inkscape/files/inkscape/0.91pre1/inkscape-0.91pre1-x64.msi/download'
$installerType = 'msi'
$installArgs = '/passive'

Install-ChocolateyPackage $packageName $installerType $installArgs $url $url64