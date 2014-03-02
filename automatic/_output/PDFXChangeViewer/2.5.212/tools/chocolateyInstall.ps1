$packageName = 'PDFXChangeViewer'
$installerType = 'exe'
$url = 'http://www.tracker-software.com/downloads/PDFXVwer.exe' 
$silentArgs = '/VERYSILENT /NOINSTASK'
$validExitCodes = @(0)

Install-ChocolateyPackage $packageName $installerType $silentArgs $url  -validExitCodes $validExitCodes
