$packageName = 'PDFXChangeViewer'
$installerType = 'exe'
$url = 'http://www.tracker-software.com/downloads/PDFXVwer.exe'
$url64 = $url
$silentArgs = '/VERYSILENT /NOINSTASK'
$validExitCodes = @(0)

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64 -validExitCodes $validExitCodes
