$packageName = 'cdrtfe'
$fileType = 'exe'
$iniFile = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\install.ini"
$silentArgs = "/VERYSILENT /LOADINF=`"$iniFile`""
# {\{DownloadUrlx64}\} gets “misused” here as 32-bit download link due to limitations of Ketarin/chocopkgup
$url = '{{DownloadUrlx64}}'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url