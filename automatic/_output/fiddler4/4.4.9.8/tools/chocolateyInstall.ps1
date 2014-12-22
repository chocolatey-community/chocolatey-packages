$packageName = 'fiddler4'
$installerType = 'EXE'
$32BitUrl  = 'http://fiddler2.com/dl/fiddler4setup.exe'
$silentArgs = '/S'
$validExitCodes = @(0)

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$32BitUrl" -validExitCodes $validExitCodes
