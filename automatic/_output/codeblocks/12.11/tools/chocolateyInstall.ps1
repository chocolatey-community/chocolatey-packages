$packageName = 'codeblocks'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://heanet.dl.sourceforge.net/project/codeblocks/Binaries/12.11/Windows/codeblocks-12.11mingw-setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url