$packageName = 'PDFCreator'
$installerType = 'exe'
$baseInstallArgs = '/VERYSILENT /NORESTART'
$fullInstallArgs = $('' +
    $baseInstallArgs + ' ' +
    '/COMPONENTS="program,ghostscript,comsamples,' +
    'languages,languages\bosnian,languages\catalan,languages\catalan_valencia,' +
    'languages\chinese_simplified,languages\chinese_traditional,' +
    'languages\corsican,languages\croatian,languages\czech,languages\danish,' +
    'languages\dutch,languages\english,languages\estonian,languages\finnish,' +
    'languages\french,languages\galician,languages\german,languages\greek,' +
    'languages\hebrew,languages\hungarian,languages\italian,languages\irish,' +
    'languages\ligurian,languages\latvian,languages\lithuanian,' +
    'languages\norwegian_bokmal,languages\polish,languages\portuguese_br,' +
    'languages\romanian,languages\russian,languages\serbian_cyrillic,' +
    'languages\slovak,languages\slovenian,languages\spanish,' +
    'languages\swedish,languages\turkish,languages\valencian_avl"'
)

$url = 'http://download.pdfforge.org/download/pdfcreator/1.9.4-beta/PDFCreator-1_9_4-setup.exe?file=AMIfv95oTwWXbT6wLzpyCZ0ZeSoJelE1Fvp2bhTw9wLaP1ICFCBCwwBMEql7JvmW1pxS226SwqgO_m0L3AVPaf1UwZIfWhGHUC_H5_KFjBke5y1y33NbWUMhctIwTx6lvnn8vQ5TaQTX52hatZZTWlEZtwOZtuipbYclqZPWNU2wJimZeM0AKyk&download'

try {

    $uninstallerPathLastPart = 'PDFCreator\unins000.exe'
    $uninstallerPath = Join-Path $env:ProgramFiles $uninstallerPathLastPart

    if (${env:ProgramFiles(x86)}) {
        $uninstallerPathx86 = Join-Path ${env:ProgramFiles(x86)} $uninstallerPathLastPart
        if (Test-Path $uninstallerPathx86) {
            $uninstallerPath = $uninstallerPathx86
        }
    }

    # Uninstall PDFCreator if older version is installed, otherwise the installation
    # of the new version will fail.
    if (Test-Path $uninstallerPath) {
        Uninstall-ChocolateyPackage $packageName $installerType $baseInstallArgs $uninstallerPath
    }

    Install-ChocolateyPackage $packageName $installerType $fullInstallArgs $url

} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}
