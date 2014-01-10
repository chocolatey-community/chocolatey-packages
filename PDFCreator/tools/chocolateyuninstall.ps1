$packageName = '{{PackageName}}'
$installerType = 'exe'


# Uninstall PDFCreator if older version is installed
if (Test-Path "$env:ProgramFiles\PDFCreator") {
    Uninstall-ChocolateyPackage $packageName $installerType "/VERYSILENT /NORESTART" "$env:ProgramFiles\PDFCreator\unins000.exe"
}

if (Test-Path "${env:ProgramFiles(x86)}\PDFCreator") {
    Uninstall-ChocolateyPackage $packageName $installerType "/VERYSILENT /NORESTART" "${env:ProgramFiles(x86)}\PDFCreator\unins000.exe"
}