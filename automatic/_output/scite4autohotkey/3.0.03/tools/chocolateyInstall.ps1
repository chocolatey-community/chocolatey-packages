$name   = 'scite4autohotkey'
$url    = 'http://www.autohotkey.net/~fincs/SciTE4AutoHotkey_3/SciTE4AHK3003_Install.exe'
$silent = '' # Silent install not possible

Install-ChocolateyPackage $name 'exe' $silent $url
