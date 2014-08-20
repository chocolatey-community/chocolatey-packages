$packageName = 'mpc-hc'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'http://optimate.dl.sourceforge.net/project/mpc-hc/MPC HomeCinema - Win32/MPC-HC_v1.7.3_x86/MPC-HC.1.7.3.x86.exe'
$url64bit = 'http://sourceforge.net/projects/mpc-hc/files/MPC%20HomeCinema%20-%20x64/MPC-HC_v1.7.3_x64/MPC-HC.1.7.3.x64.exe/download'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit