$packageName = 'rdcman'
$installerType = 'MSI'
$32BitUrl = 'http://download.microsoft.com/download/5/2/8/5282718D-87FE-4A4F-9226-789ACF368DB1/RDCMan.msi'
$silentArgs = '/quiet'
$validExitCodes = @(0,3010)

Install-ChocolateyPackage $packageName $installerType $silentArgs $32BitUrl -validExitCodes $validExitCodes