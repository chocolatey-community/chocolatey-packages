$packageName = 'ffdshow'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'http://sourceforge.net/projects/ffdshow-tryout/files/Official releases/generic build (stable)/ffdshow_rev4531_20140628.exe/download'
$url64 = 'http://sourceforge.net/projects/ffdshow-tryout/files/Official releases/64-bit/ffdshow_rev4531_20140628_x64.exe/download'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64
