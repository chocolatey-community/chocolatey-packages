$packageName = 'aptana-studio'
$fileType = 'exe'
$silentArgs = '/passive /norestart'
$url = 'http://sourceforge.net/projects/aptana.mirror/files/Aptana Studio 3.6.1/Aptana_Studio_3_Setup_3.6.1.exe/download'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
