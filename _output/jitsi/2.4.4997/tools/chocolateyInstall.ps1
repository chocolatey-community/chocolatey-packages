$packageName = 'jitsi'
$installerType = 'msi'
$url = 'https://download.jitsi.org/jitsi/msi/jitsi-2.4.4997-x86.msi'
$url64 = 'https://download.jitsi.org/jitsi/msi/jitsi-2.4.4997-x64.msi'
$silentArgs = '/passive'
$validExitCodes = @(0) 

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64 -validExitCodes $validExitCodes
