$packageName = 'tightvnc'
$fileType = 'msi'
$silentArgs = '/quiet /norestart'
$url = 'http://www.tightvnc.com/download/2.7.7/tightvnc-2.7.7-setup-32bit.msi'
$url64bit = 'http://www.tightvnc.com/download/2.7.7/tightvnc-2.7.7-setup-64bit.msi'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit