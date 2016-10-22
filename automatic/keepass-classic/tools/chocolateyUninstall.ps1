$unfile = "KeePass Password Safe/unins000.exe"

if (Test-Path "${Env:ProgramFiles(x86)}\$unfile") {
  $unpath = "${Env:ProgramFiles(x86)}\$unfile"
}
else {
  $unpath = "${Env:ProgramFiles}\$unfile"
}
Uninstall-ChocolateyPackage 'keepass-classic' 'exe' '/VERYSILENT' "$unpath"
