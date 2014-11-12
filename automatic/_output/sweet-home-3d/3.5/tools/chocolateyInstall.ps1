$packageName = 'sweet-home-3d'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
# {\{DownloadUrlx64}\} gets “misused” here as 32-bit download link due to limitations of Ketarin/chocopkgup
$url = 'http://sourceforge.net/projects/sweethome3d/files/SweetHome3D/SweetHome3D-3.5/SweetHome3D-3.5-windows.exe/download'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
