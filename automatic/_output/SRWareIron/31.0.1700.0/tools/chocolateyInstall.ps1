$packageName = 'SRWareIron'
$installerType = 'exe'
$url = 'http://www.srware.net/downloads/srware_iron.exe'
$silentArgs = '/silent'
$validExitCodes = @(0)

Install-ChocolateyPackage $packageName $installerType $silentArgs $url  -validExitCodes $validExitCodes