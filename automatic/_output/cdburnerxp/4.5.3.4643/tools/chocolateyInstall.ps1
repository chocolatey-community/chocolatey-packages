$packageName = 'cdburnerxp'
$installerType = 'EXE'
$32BitUrl  = 'http://download.cdburnerxp.se/cdbxp_setup_4.5.3.4643.exe'
$64BitUrl  = 'http://download.cdburnerxp.se/cdbxp_setup_4.5.3.4643_x64.exe'
$silentArgs = '/verysilent'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$32BitUrl" "$64BitUrl" -validExitCodes $validExitCodes