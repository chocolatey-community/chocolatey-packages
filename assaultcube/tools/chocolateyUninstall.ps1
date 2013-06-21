if (Test-Path "${Env:ProgramFiles(x86)}\AssaultCube_v{{PackageVersion}}\Uninstall.exe") {
    $unpath = "${Env:ProgramFiles(x86)}\AssaultCube_v{{PackageVersion}}\Uninstall.exe"
}
else {
    $unpath = "${Env:ProgramFiles}\AssaultCube_v{{PackageVersion}}\Uninstall.exe"
}
Uninstall-ChocolateyPackage 'assaultcube' 'exe' '/S' "$unpath"