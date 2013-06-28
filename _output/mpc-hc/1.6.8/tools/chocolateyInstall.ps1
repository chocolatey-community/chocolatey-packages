$packageName = 'mpc-hc'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'http://garr.dl.sourceforge.net/project/mpc-hc/MPC HomeCinema - Win32/MPC-HC_v1.6.8_x86/MPC-HC.1.6.8.x86.exe'
$url64bit = 'http://kent.dl.sourceforge.net/project/mpc-hc/MPC HomeCinema - x64/MPC-HC_v1.6.8_x64/MPC-HC.1.6.8.x64.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit