$packageName = 'ffdshow'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
# \{\{DownloadUrlx64\}\} gets “misused” here as has to store both 32- and 64-bit URLs
$urlHash = @{'url32' = 'http://sourceforge.net/projects/ffdshow-tryout/files/Official%20releases/generic%20build%20%28stable%29/ffdshow_rev4531_20140628.exe'; 'url64' = 'http://sourceforge.net/projects/ffdshow-tryout/files/Official%20releases/64-bit/ffdshow_rev4531_20140628_x64.exe'}

Install-ChocolateyPackage $packageName $fileType $silentArgs $urlHash.url32 $urlHash.url64