$packageName = 'classic-shell'
$installerType = 'exe'
$installArguments = '/passive'
$url = 'http://www.mediafire.com/download/62xr4o45m4b2i85/ClassicShellSetup_4_1_0.exe'

Install-ChocolateyPackage $packageName $installerType $installArguments $url
