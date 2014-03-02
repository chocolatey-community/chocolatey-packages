$packageName = 'cdrtfe'
$fileType = 'exe'
$iniFile = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\install.ini"
$silentArgs = "/VERYSILENT /LOADINF=`"$iniFile`""
# {\{DownloadUrlx64}\} gets “misused” here as 32-bit download link due to limitations of Ketarin/chocopkgup
$url = 'http://sourceforge.net/projects/cdrtfe/files/cdrtfe/cdrtfe%201.5.2/cdrtfe-1.5.2.exe/download'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url