$packageName = 'scribus'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://sourceforge.net/projects/scribus/files/scribus/{{PackageVersion}}/scribus-{{PackageVersion}}-windows.exe/download'
$url64bit = 'http://sourceforge.net/projects/scribus/files/scribus/{{PackageVersion}}/scribus-{{PackageVersion}}-windows-x64.exe/download'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit