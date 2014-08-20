#NOTE: Please remove any commented lines to tidy up prior to releasing the package, including this one

$packageName = 'jitsi' # arbitrary name for the package, used in messages
$installerType = 'MSI' #only one of these two: exe or msi
$url = 'https://download.jitsi.org/jitsi/msi/jitsi-2.2.4603.9615-x86.msi'
$url64 = 'https://download.jitsi.org/jitsi/msi/jitsi-2.2.4603.9615-x64.msi'
$silentArgs = '/quiet' 
$validExitCodes = @(0) 


Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64" -validExitCodes $validExitCodes



