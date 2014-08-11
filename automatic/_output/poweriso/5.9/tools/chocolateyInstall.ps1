$packageName = 'poweriso'
$installerType = 'EXE'
$32BitUrl  = 'http://192.155.93.226/PowerISO5.exe'
$64BitUrl  = $32BitUrl
$silentArgs = '/S'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$32BitUrl" "$64BitUrl" -validExitCodes $validExitCodes