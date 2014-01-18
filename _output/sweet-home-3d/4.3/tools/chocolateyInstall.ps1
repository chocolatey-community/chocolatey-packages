$packageName = 'sweet-home-3d'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'http://sourceforge.net/projects/sweethome3d/files/SweetHome3D/SweetHome3D-4.3/SweetHome3D-4.3-windows.exe/download' # { {DownloadUrlx64} } is not the actual 64-bit URL. It’s only a workaround for files hosted on SourceForge and contains the 32-bit URL

Install-ChocolateyPackage $packageName $fileType $silentArgs $url