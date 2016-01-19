$packageName = '{{PackageName}}'
$installerType = 'exe'
$url = 'http://www.srware.net/downloads/srware_iron.exe'
$url64 = 'http://www.srware.net/downloads/srware_iron64.exe'
$silentArgs = '/silent'
$validExitCodes = @(0)

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64  -validExitCodes $validExitCodes
