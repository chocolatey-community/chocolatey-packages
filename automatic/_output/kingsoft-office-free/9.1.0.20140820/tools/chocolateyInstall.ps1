$packageName = 'kingsoft-office-free'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://www.ksosoft.com/download/office_free_2013.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
