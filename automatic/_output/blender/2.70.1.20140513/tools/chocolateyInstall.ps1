$packageName = 'blender'
$installerType = 'exe'
$url = 'http://ftp.nluug.nl/pub/graphics/blender/release/Blender2.70/blender-2.70a-windows32.exe'
$url64 = 'http://ftp.nluug.nl/pub/graphics/blender/release/Blender2.70/blender-2.70a-windows64.exe'
$silentArgs = '/S'
$validExitCodes = @(0)

Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64 -validExitCodes $validExitCodes
