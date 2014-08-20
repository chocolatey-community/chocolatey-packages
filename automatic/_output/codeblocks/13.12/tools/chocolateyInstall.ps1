$packageName = 'codeblocks'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://heanet.dl.sourceforge.net/project/codeblocks/Binaries/13.12/Windows/codeblocks-13.12mingw-setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url