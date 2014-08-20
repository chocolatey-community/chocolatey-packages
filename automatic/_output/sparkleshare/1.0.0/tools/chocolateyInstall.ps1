$packageName = 'sparkleshare'
$fileType = 'msi'
$silentArgs = '/qn'
$url = 'https://github.com/downloads/hbons/SparkleShare/sparkleshare-windows-1.0.0.msi'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url