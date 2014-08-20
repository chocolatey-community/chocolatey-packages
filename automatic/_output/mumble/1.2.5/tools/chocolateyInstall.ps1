$packageName = 'mumble' 
$installerType = 'MSI' 
$url = 'http://sourceforge.net/projects/mumble/files/Mumble/1.2.5/mumble-1.2.5.msi/download' # download url
$silentArgs = '/quiet' 
$validExitCodes = @(0) 


Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes
