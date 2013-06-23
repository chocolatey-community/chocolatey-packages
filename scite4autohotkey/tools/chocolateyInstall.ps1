$name   = '{{PackageName}}'
$url    = '{{DownloadUrl}}'
$silent = '' # Silent install not possible

Install-ChocolateyPackage $name 'exe' $silent $url
