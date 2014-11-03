$name	= 'unchecky'
$url	= '{{DownloadUrl}}'

# unchecky_setup.exe -install -path <installation_path> [-lang <unchecky_language>] - get command line arguments

Install-ChocolateyPackage $name 'exe' '-install' $url
