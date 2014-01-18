$packageName = 'mpc-hc'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$urlArray = @('http://sourceforge.net/projects/mpc-hc/files/MPC%20HomeCinema%20-%20Win32/MPC-HC_v1.7.1_x86/MPC-HC.1.7.1.x86.exe/download', 'http://sourceforge.net/projects/mpc-hc/files/MPC%20HomeCinema%20-%20x64/MPC-HC_v1.7.1_x64/MPC-HC.1.7.1.x64.exe/download') # { {DownloadUrlx64} } here is not the actual 64-bit URL, but it’s an array that contains both 32- and 64-bit URLs.
$url = $urlArray[0] 
$url64bit = $urlArray[1]

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit