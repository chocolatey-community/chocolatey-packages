$packageName = 'maxima'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
# {\{DownloadUrlx64}\} gets “misused” here as 32-bit download link due to limitations of Ketarin/chocopkgup
$url = 'http://sourceforge.net/projects/maxima/files/Maxima-Windows/5.34.1-Windows/maxima-5.34.1.exe/download'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
