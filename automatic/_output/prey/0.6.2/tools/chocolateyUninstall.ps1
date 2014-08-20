$unpath = "$env:SystemDrive\Prey\platform\windows\Uninstall.exe"
Uninstall-ChocolateyPackage 'prey' 'exe' '/S' "$unpath"