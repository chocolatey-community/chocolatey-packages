$packageName = 'mpc-hc'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'http://freefr.dl.sourceforge.net/project/mpc-hc/MPC HomeCinema - Win32/MPC-HC_v1.7.0_x86/MPC-HC.1.7.0.x86.exe'
$url64bit = 'http://kent.dl.sourceforge.net/project/mpc-hc/MPC HomeCinema - x64/MPC-HC_v1.7.0_x64/MPC-HC.1.7.0.x64.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit