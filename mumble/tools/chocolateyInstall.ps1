$packageName = 'mumble' 
$installerType = 'MSI' 
$url = 'http://sourceforge.net/projects/mumble/files/Mumble/{{PackageVersion}}/mumble-{{PackageVersion}}.msi/download' # download url
$silentArgs = '/quiet' 
$validExitCodes = @(0) 


Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" -validExitCodes $validExitCodes
