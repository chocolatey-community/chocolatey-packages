$unfile = "${Env:ProgramFiles}\Blender Foundation\Blender\uninstall.exe"

Uninstall-ChocolateyPackage 'blender' 'exe' '/S' "$unfile"