$packageName = 'mpc-hc'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
# {\{DownloadUrlx64}\} gets “misused” here as 32- and 64-bit link array due to limitations of Ketarin/chocopkgup
$urlsArray = @('http://sourceforge.net/projects/mpc-hc/files/MPC%20HomeCinema%20-%20Win32/MPC-HC_v1.7.5_x86/MPC-HC.1.7.5.x86.exe/download', 'http://sourceforge.net/projects/mpc-hc/files/MPC%20HomeCinema%20-%20x64/MPC-HC_v1.7.5_x64/MPC-HC.1.7.5.x64.exe/download')
$url = $urlsArray[0]
$url64bit = $urlsArray[1]

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit