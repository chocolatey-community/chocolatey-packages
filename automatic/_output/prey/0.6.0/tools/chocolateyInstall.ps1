$packageName = 'prey'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://preyproject.com/releases/0.6.0/prey-0.6.0-win.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url