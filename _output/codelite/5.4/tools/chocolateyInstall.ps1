$packageName = 'codelite'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'http://sourceforge.net/projects/codelite/files/Mirrors/codelite-5.4-mingw4.8.1.exe.7z/download' # This variable is actually not the 64-bit installer, it is only a workaround to get the automatic package working

Install-ChocolateyPackage $packageName $fileType $silentArgs $url