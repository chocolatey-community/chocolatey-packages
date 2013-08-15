$name   = 'scite4autohotkey'
$url    = 'http://fincs.ahk4.net/scite4ahk/dl/SciTE4AHK3004_Install.exe'
$silent = '' # Silent install not possible

Install-ChocolateyPackage $name 'exe' $silent $url
