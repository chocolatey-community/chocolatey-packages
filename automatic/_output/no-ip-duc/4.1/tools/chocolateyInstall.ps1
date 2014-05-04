$packageName = 'no-ip-duc'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://www.noip.com/client/DUCSetup_v4_1_0.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url