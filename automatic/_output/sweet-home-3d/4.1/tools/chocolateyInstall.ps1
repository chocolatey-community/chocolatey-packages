$packageName = 'sweet-home-3d'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'http://surfnet.dl.sourceforge.net/project/sweethome3d/SweetHome3D/SweetHome3D-4.1/SweetHome3D-4.1-windows.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url