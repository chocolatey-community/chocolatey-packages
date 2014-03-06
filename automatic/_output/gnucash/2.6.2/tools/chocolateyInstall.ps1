$packageName = 'gnucash'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'
# {\{DownloadUrlx64}\} gets “misused” here as 32-bit download link due to limitations of Ketarin/chocopkgup
$url = 'http://sourceforge.net/projects/gnucash/files/gnucash%20%28stable%29/2.6.2/gnucash-2.6.2-setup.exe/download'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url