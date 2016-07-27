$unfile = "Mozilla Firefox\uninstall\helper.exe"

if (Test-Path "${Env:ProgramFiles(x86)}\$unfile"){
   $unpath = "${Env:ProgramFiles(x86)}\$unfile"
}
else {
   $unpath = "${Env:ProgramFiles}\$unfile"
}
Uninstall-ChocolateyPackage 'Mozilla Firefox' 'exe' '/S' "$unpath"
