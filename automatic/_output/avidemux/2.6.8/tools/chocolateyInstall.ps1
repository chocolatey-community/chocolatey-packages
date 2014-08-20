$packageName = 'avidemux'
$fileType = 'exe'
$silentArgs = '/S'
# {\{DownloadUrlx64}\} gets “misused” here as 32- and 64-bit link array due to limitations of Ketarin/chocopkgup
$urlsArray = @('http://sourceforge.net/projects/avidemux/files/avidemux/2.6.8/avidemux_2.6.8_win32.exe/download', 'http://sourceforge.net/projects/avidemux/files/avidemux/2.6.8/avidemux_2.6.8_win64.exe/download')
$url = $urlsArray[0]
$url64bit = $urlsArray[1]
$validExitCodes = @(0,1223)

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit -validExitCodes $validExitCodes