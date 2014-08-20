$packageName = 'scribus'
$fileType = 'exe'
$silentArgs = '/S'
# {\{DownloadUrlx64}\} gets “misused” here as 32- and 64-bit link array due to limitations of Ketarin/chocopkgup
$urlArray = @('http://sourceforge.net/projects/scribus/files/scribus/1.4.4/scribus-1.4.4-windows.exe/download', 'http://sourceforge.net/projects/scribus/files/scribus/1.4.4/scribus-1.4.4-windows-x64.exe/download')
$url = $urlArray[0]
$url64bit = $urlArray[1]

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit