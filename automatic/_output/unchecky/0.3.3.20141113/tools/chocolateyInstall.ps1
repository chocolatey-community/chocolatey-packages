$name = 'unchecky'
$url = 'http://unchecky.com/files/unchecky_setup.exe'

# unchecky_setup.exe -install -path <installation_path> [-lang <unchecky_language>] - get command line arguments

Install-ChocolateyPackage $name 'exe' '-install' $url
