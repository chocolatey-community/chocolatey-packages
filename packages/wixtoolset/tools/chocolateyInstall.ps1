$packageName = 'wixtoolset'
$installerType = 'EXE'
$32BitUrl = 'http://wixtoolset.org/downloads/v3.10.3.3007/wix310.exe'
$silentArgs = '/q'
$validExitCodes = @(0)

Install-ChocolateyPackage $packageName $installerType $silentArgs $32BitUrl -validExitCodes $validExitCodes
