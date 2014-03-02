$uninstaller = "$env:ProgramFiles\AssaultCube\Uninstall.exe"
$uninstallerx86 = "${env:ProgramFiles(x86)}\AssaultCube\Uninstall.exe"

if (Test-Path $uninstaller) {
    $unpath = $uninstaller
}
else {
    $unpath = $uninstallerx86
}
Uninstall-ChocolateyPackage 'assaultcube' 'exe' '/S' $unpath