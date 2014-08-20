$packageName = 'sweet-home-3d'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'http://netcologne.dl.sourceforge.net/project/sweethome3d/SweetHome3D/SweetHome3D-4.2/SweetHome3D-4.2-windows.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url