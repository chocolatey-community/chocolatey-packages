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

$url = 'http://download.pdfforge.org/download/pdfcreator/2.0.1/PDFCreator-2_0_1-setup.exe?file=AMIfv97aL33gJkzgjGlaFs8RH--fu5YEdDxwebMoTF80PCHESFOi7qiR9raejZqRcpQNkxf-Cw195Ie1XklT1HO1wIW8_kFVkZ_eFUSes-nsDoS9AzHhuO9J0WHRyhn-I9tN-DBu2S-CRMsWYi76zVq5T19K4WbJVT-oA0WuhV3JEq3Alii22j4&download'

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
