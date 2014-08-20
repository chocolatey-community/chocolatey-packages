$packageName = 'classic-shell'
$installerType = 'exe'
$installArguments = '/passive'
$url = 'http://www.mediafire.com/download/bvfx3vfkjohd8f6/ClassicShellSetup_4_0_6.exe'

Install-ChocolateyPackage $packageName $installerType $installArguments $url
