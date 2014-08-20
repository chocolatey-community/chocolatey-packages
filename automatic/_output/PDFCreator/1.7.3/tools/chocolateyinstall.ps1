$packageName = 'PDFCreator'
$installerType = 'exe'
$silentArgs = '/VERYSILENT /NORESTART /COMPONENTS="program,ghostscript,comsamples,languages,languages\bosnian,languages\catalan,languages\catalan_valencia,languages\chinese_simplified,languages\chinese_traditional,languages\corsican,languages\croatian,languages\czech,languages\danish,languages\dutch,languages\english,languages\estonian,languages\finnish,languages\french,languages\galician,languages\german,languages\greek,languages\hebrew,languages\hungarian,languages\italian,languages\irish,languages\ligurian,languages\latvian,languages\lithuanian,languages\norwegian_bokmal,languages\polish,languages\portuguese_br,languages\romanian,languages\russian,languages\serbian_cyrillic,languages\slovak,languages\slovenian,languages\spanish,languages\swedish,languages\turkish,languages\valencian_avl"'
$url = 'http://white.download.pdfforge.org/pdfcreator/1.7.3/PDFCreator-1_7_3_setup.exe'

# Uninstall PDFCreator if older version is installed
if (Test-Path "$env:ProgramFiles\PDFCreator") {
    Uninstall-ChocolateyPackage $packageName $installerType "/VERYSILENT /NORESTART" "$env:ProgramFiles\PDFCreator\unins000.exe"
}

if (Test-Path "${env:ProgramFiles(x86)}\PDFCreator") {
    Uninstall-ChocolateyPackage $packageName $installerType "/VERYSILENT /NORESTART" "${env:ProgramFiles(x86)}\PDFCreator\unins000.exe"
}

Install-ChocolateyPackage $packageName $installerType $silentArgs $url