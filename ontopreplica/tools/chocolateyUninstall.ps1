$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/S'
$file = "$env:LOCALAPPDATA\OnTopReplica\OnTopReplica-Uninstall.exe"

Uninstall-ChocolateyPackage $packageName $fileType $silentArgs $file