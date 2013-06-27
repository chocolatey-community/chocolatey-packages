$unfile = "PC-WELT\pcwRunAs4\unins000.exe"

if (Test-Path "${Env:ProgramFiles(x86)}\$unfile") {
    $unpath = "${Env:ProgramFiles(x86)}\$unfile"
}
else {
    $unpath = "${Env:ProgramFiles}\$unfile"
}
Uninstall-ChocolateyPackage 'pcwrunas' 'exe' '/verysilent' "$unpath"