$packageName = 'ext2fsd'
$fileType = 'exe'
$silentArgs = '/VERYSILENT'

# {\{DownloadUrlx64}\} gets “misused” here as 32-bit download link due to limitations of Ketarin/chocopkgup
$url = 'http://sourceforge.net/projects/ext2fsd/files/Ext2fsd/0.52/Ext2Fsd-0.52.exe/download'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url