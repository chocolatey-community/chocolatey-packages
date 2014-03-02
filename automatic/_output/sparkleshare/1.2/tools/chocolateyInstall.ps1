$packageName = 'sparkleshare'
$fileType = 'msi'
$silentArgs = '/qn'
$url = 'https://bitbucket.org/hbons/sparkleshare/downloads/sparkleshare-windows-1.2.msi'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url