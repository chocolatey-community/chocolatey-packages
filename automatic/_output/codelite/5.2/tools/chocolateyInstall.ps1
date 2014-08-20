$packageName = 'codelite'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'http://sourceforge.net/projects/codelite/files/Releases/codelite-5.2/codelite-5.2-mingw4.7.1.exe/download' # This variable is actually not the 64-bit installer, it is only a workaround to get the automatic package working

Install-ChocolateyPackage $packageName $fileType $silentArgs $url