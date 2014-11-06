$packageName = 'wixtoolset'
$installerType = 'EXE'
$32BitUrl = 'https://wix.codeplex.com/downloads/get/925661'
$silentArgs = '/q'
$validExitCodes = @(0)

Install-ChocolateyPackage $packageName $installerType '/q' $32BitUrl -validExitCodes $validExitCodes