$packageName = 'cdrtfe'
$fileType = 'exe'
$installArgs = "/VERYSILENT"
# {\{DownloadUrlx64}\} gets “misused” here as 32-bit download link due to limitations of Ketarin/chocopkgup
$url = 'http://sourceforge.net/projects/cdrtfe/files/cdrtfe/cdrtfe%201.5.3/cdrtfe-1.5.3.exe/download'

Install-ChocolateyPackage $packageName $fileType $installArgs $url