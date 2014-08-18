$packageName = '{{PackageName}}'
$unfile = 'qBittorrent\uninst.exe'

if (Test-Path "${Env:ProgramFiles(x86)}\$unfile") {
	$unpath = "${Env:ProgramFiles(x86)}\$unfile"
}
else {
	$unpath = "${Env:ProgramFiles}\$unfile"
}
Uninstall-ChocolateyPackage $packageName 'exe' '/S' $unpath
