$packageName = 'winff'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'https://docs.google.com/uc?authuser=0&id=0B8HoAIi30ZDkano0TWZseUdhejQ&export=download'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
