$packageName = 'winff'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
$url = 'https://docs.google.com/uc?authuser=0&id=0B8HoAIi30ZDkQWQtMG5TV0tCX1U&export=download'
$url64bit = 'https://docs.google.com/uc?authuser=0&id=0B8HoAIi30ZDkM2t0ZHVyQ3Y3Wjg&export=download'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit