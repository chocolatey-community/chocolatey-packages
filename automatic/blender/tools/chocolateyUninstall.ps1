$packageName = '{{PackageName}}'
$unfile = "${Env:ProgramFiles}\Blender Foundation\Blender\uninstall.exe"

if (Test-Path $unfile) {
  Uninstall-ChocolateyPackage $packageName 'exe' '/S' $unfile
}
