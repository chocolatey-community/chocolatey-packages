$packageName = 'blender'
$installerType = 'exe'
$url = 'http://download.blender.org/release/Blender2.72/blender-2.72a-windows32.exe'
$url64 = 'http://download.blender.org/release/Blender2.72/blender-2.72a-windows64.exe'
$silentArgs = '/S'
$validExitCodes = @(0)

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64 -validExitCodes $validExitCodes
