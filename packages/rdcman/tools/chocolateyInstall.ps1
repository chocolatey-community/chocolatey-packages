$packageName = 'rdcman'
$installerType = 'MSI'
$32BitUrl = 'http://download.microsoft.com/download/A/F/0/AF0071F3-B198-4A35-AA90-C68D103BDCCF/rdcman.msi'
$silentArgs = '/quiet'
$validExitCodes = @(0,3010)

Install-ChocolateyPackage $packageName $installerType $silentArgs $32BitUrl -validExitCodes $validExitCodes