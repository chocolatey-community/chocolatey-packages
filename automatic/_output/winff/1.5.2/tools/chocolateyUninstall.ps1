if (Test-Path "${Env:ProgramFiles(x86)}\WinFF\unins000.exe") {
    $unpath = "${Env:ProgramFiles(x86)}\WinFF\unins000.exe"
}
else {
    $unpath = "${Env:ProgramFiles}\WinFF\unins000.exe"
}
Uninstall-ChocolateyPackage 'winff' 'exe' '/verysilent' "$unpath"