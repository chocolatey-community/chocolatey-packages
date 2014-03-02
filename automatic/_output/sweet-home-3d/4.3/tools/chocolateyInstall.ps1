$packageName = 'sweet-home-3d'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'http://freefr.dl.sourceforge.net/project/sweethome3d/SweetHome3D/SweetHome3D-4.3/SweetHome3D-4.3-windows.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url