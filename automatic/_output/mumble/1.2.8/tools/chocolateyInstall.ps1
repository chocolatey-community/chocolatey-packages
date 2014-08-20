$packageName = 'mumble' 
$installerType = 'msi' 
# {\{DownloadUrlx64}\} gets “misused” here as 32-bit download link due to limitations of Ketarin/chocopkgup
$url = 'http://sourceforge.net/projects/mumble/files/Mumble/1.2.8/mumble-1.2.8.msi/download'
$silentArgs = '/passive /norestart' 
$validExitCodes = @(0) 


Install-ChocolateyPackage $packageName $installerType $silentArgs $url -validExitCodes $validExitCodes
