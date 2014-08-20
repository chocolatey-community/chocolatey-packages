$packageName = 'ontopreplica'
$fileType = 'exe'
$silentArgs = '/S'
$url = 'http://www.klopfenstein.net/public/Uploads/ontopreplica/ontopreplica-setup.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url