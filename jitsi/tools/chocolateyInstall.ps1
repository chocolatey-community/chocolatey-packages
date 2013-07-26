#NOTE: Please remove any commented lines to tidy up prior to releasing the package, including this one

$packageName = 'jitsi' # arbitrary name for the package, used in messages
$installerType = 'MSI' #only one of these two: exe or msi
$url = '{{DownloadUrl}}'
$url64 = '{{DownloadUrlx64}}'
$silentArgs = '/quiet' 
$validExitCodes = @(0) 


Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64" -validExitCodes $validExitCodes



