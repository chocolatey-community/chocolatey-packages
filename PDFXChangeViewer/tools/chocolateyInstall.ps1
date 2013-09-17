$packageName = '{{PackageName}}'
$installerType = 'exe'
$url = '{{DownloadUrl}}' 
$silentArgs = '/VERYSILENT /NOINSTASK'
$validExitCodes = @(0)

Install-ChocolateyPackage $packageName $installerType $silentArgs $url  -validExitCodes $validExitCodes
