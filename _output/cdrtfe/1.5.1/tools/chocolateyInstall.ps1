$packageName = 'cdrtfe'
$fileType = 'exe'
$iniFile = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\install.ini"
$silentArgs = "/VERYSILENT /LOADINF=`"$iniFile`""
$url = 'http://netcologne.dl.sourceforge.net/project/cdrtfe/cdrtfe/cdrtfe 1.5.1/cdrtfe-1.5.1.exe'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url