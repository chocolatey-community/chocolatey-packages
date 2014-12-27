$packageId = 'classic-shell'
$fileType = 'exe'
$fileArgs = '/passive'
$url = 'http://www.mediafire.com/download/62xr4o45m4b2i85/ClassicShellSetup_4_1_0.exe'

# Installer is for both 32- and 64-bit versions
$url64 = $url

Install-ChocolateyPackage $packageId $fileType $fileArgs $url $url64